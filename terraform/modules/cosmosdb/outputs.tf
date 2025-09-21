output "cosmosdb_sql_database_id" {
  value = azurerm_cosmosdb_sql_database.db.id
}

output "cosmosdb_sql_container_id" {
  value = azurerm_cosmosdb_sql_container.container.id
}

output "cosmosdb_private_endpoint_id" {
  value = azurerm_private_endpoint.cosmos_pe.id
}

output "cosmosdb_private_endpoint_ip" {
  value = azurerm_private_endpoint.cosmos_pe.private_service_connection[0].private_ip_address
}
