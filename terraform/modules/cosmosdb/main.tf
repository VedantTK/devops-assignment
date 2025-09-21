# Cosmos DB Account
resource "azurerm_cosmosdb_account" "account" {
  name                = "${var.project_name}-${var.environment}-cosmos"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  # Security
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  # Send logs to Log Analytics (if configured)
  capabilities {
    name = "EnableServerless" # optional, or keep autoscale below
  }

  tags = var.tags
}

# Private Endpoint for Cosmos DB
resource "azurerm_private_endpoint" "cosmos_pe" {
  name                = "${var.project_name}-${var.environment}-cosmos-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "cosmosdb-privatesc"
    private_connection_resource_id = azurerm_cosmosdb_account.account.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }
}

# Cosmos DB SQL Database
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "${var.project_name}-${var.environment}-db"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name

  # Autoscale throughput: adjusts between 400–max
  autoscale_settings {
    max_throughput = var.cosmos_max_ru
  }
}

resource "azurerm_cosmosdb_sql_container" "container" {
  name                = "${var.project_name}-${var.environment}-container"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
  database_name       = azurerm_cosmosdb_sql_database.db.name

  # Partition key (paths must be a list)
  partition_key_paths = [var.partition_key_path]
  partition_key_version = 2

  autoscale_settings {
    max_throughput = var.cosmos_max_ru
  }
}


