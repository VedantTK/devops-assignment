########################################################
# Root Terraform Module
# Deploys complete Azure infrastructure for DevOps assignment
# Modules included:
# - Networking (VNet + Subnets)
# - Key Vault
# - Cosmos DB
# - Application Insights
# - Function App
# - RBAC (Admin / Developer)
########################################################

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags     = var.tags
}

# Networking Module
module "networking" {
  source              = "./modules/networking"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Key Vault Module
module "keyvault" {
  source              = "./modules/keyvault"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

module "cosmosdb" {
  source              = "./modules/cosmosdb"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.networking.subnet_data_id
  tags                = var.tags

  # New variables for scaling
  failover_location   = "West US"
  cosmos_max_ru       = 20000
  partition_key_path  = "/studentId"
}

# Application Insights Module
module "appinsights" {
  source              = "./modules/appinsights"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Function App Module
module "function_app" {
  source               = "./modules/function_app"
  project_name         = var.project_name
  environment          = var.environment
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  tags                 = var.tags

  # Monitoring
  app_insights_key     = module.appinsights.instrumentation_key

  # Networking
  subnet_id            = module.networking.subnet_functions_id
  allowed_subnet_ids   = [module.networking.subnet_functions_id]

  # Storage
  storage_account_name = lower("${var.project_name}${var.environment}sa")
}



# RBAC Module
module "rbac" {
  source              = "./modules/rbac"
  project_name        = var.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_id   = azurerm_resource_group.rg.id
  admin_object_id     = var.admin_object_id
  dev_object_id       = var.dev_object_id
}
