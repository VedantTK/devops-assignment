# -----------------------------
# Resource Group
# -----------------------------
output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.rg.name
}

# -----------------------------
# Networking
# -----------------------------
output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "subnet_functions_id" {
  description = "ID of the subnet for Function App"
  value       = module.networking.subnet_functions_id
}

output "subnet_data_id" {
  description = "ID of the subnet for Cosmos DB Private Endpoint"
  value       = module.networking.subnet_data_id
}

# -----------------------------
# Cosmos DB
# -----------------------------
output "cosmosdb_endpoint" {
  description = "Cosmos DB account endpoint"
  value       = module.cosmosdb.cosmosdb_endpoint
}

# Optional: Primary Key for Cosmos DB (for CI/CD injection)
output "cosmosdb_primary_key" {
  description = "Primary key of Cosmos DB account (sensitive)"
  value       = module.cosmosdb.cosmosdb_primary_key
  sensitive   = true
}

# -----------------------------
# Key Vault
# -----------------------------
output "keyvault_id" {
  description = "ID of the Key Vault"
  value       = module.keyvault.keyvault_id
}

output "keyvault_uri" {
  description = "URI of the Key Vault"
  value       = module.keyvault.keyvault_uri
}

# -----------------------------
# Application Insights
# -----------------------------
output "appinsights_instrumentation_key" {
  description = "Instrumentation Key of App Insights"
  value       = module.appinsights.app_insights_key
}

# -----------------------------
# Function App
# -----------------------------
output "function_app_url" {
  description = "Default hostname / URL of the Function App"
  value       = module.function_app.function_app_url
}

# -----------------------------
# RBAC Role Assignments
# -----------------------------
output "admin_role_assignment_id" {
  description = "ID of Admin role assignment"
  value       = module.rbac.admin_role_assignment_id
}

output "developer_role_assignment_id" {
  description = "ID of Developer role assignment"
  value       = module.rbac.developer_role_assignment_id
}
