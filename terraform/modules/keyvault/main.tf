# Key Vault
resource "azurerm_key_vault" "vault" {
  name                        = "${var.project_name}-${var.environment}-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  tags                        = var.tags
}

# Example secret
resource "azurerm_key_vault_secret" "example" {
  name         = "CosmosDBConnection"
  value        = "placeholder-secret"
  key_vault_id = azurerm_key_vault.vault.id
}
