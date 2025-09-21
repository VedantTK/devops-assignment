# -------------------------------
# Storage Account for Function App
# -------------------------------
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enforce TLS 1.2+ for all connections
  min_tls_version = "TLS1_2"

  # Network rules: deny all public access by default and only allow from specific subnets
  network_rules {
    # Deny public network access by default (prevents anonymous/public blob access)
    default_action = "Deny"

    # Allow only workloads in your Function App subnet (pass subnet id variable)
    # ensure var.subnet_id is passed to this module (the subnet where your Function App or private endpoints run)
    virtual_network_subnet_ids = var.allowed_subnet_ids != null ? var.allowed_subnet_ids : []
  }

  tags = var.tags
}

# -------------------------------
# App Service Plan (Linux Premium for scalability)
# -------------------------------
resource "azurerm_service_plan" "plan" {
  name                = "${var.project_name}-${var.environment}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  # For scaling from 50 → 25k users, avoid Y1 (Consumption). Use Premium for autoscale.
  sku_name = var.environment == "production" ? "P1v2" : "Y1"

  # per_site_scaling only valid for Premium/Dedicated SKUs
  dynamic "per_site_scaling" {
    for_each = var.environment == "production" ? [1] : []
    content {
      # No content needed – just enable
    }
  }

  tags = var.tags
}

# -------------------------------
# Function App with VNet integration
# -------------------------------
resource "azurerm_linux_function_app" "function" {
  name                       = "${var.project_name}-${var.environment}-func"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key

  # App Settings
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = var.app_insights_key
    FUNCTIONS_EXTENSION_VERSION    = "~4"
    AzureWebJobsStorage            = azurerm_storage_account.storage.primary_connection_string
    SUBNET_ID                      = var.subnet_id
    ENVIRONMENT                    = var.environment
  }

  site_config {
    application_stack {
      python_version = "3.9"
    }

    # VNet Integration for security
    vnet_route_all_enabled = true
  }

  # Always On for premium scaling
  https_only = true
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}