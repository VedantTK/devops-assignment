# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-${var.environment}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

# Subnet for Function Apps
resource "azurerm_subnet" "functions" {
  name                 = "subnet-functions"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  # Enables VNet integration for Function Apps
  service_endpoints = ["Microsoft.Web"]
}

# Subnet for Private Endpoints (Cosmos DB, Key Vault)
resource "azurerm_subnet" "data" {
  name                 = "subnet-data"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Shared Subnet for future use
resource "azurerm_subnet" "shared" {
  name                 = "subnet-shared"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}
