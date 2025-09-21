output "keyvault_id" {
  value = azurerm_key_vault.vault.id
}

output "keyvault_uri" {
  value = azurerm_key_vault.vault.vault_uri
}
