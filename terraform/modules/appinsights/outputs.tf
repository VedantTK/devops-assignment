# Application Insights Instrumentation Key
output "app_insights_id" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}

# Optional: Application Insights Resource ID
output "app_insights_resource_id" {
  value = azurerm_application_insights.appinsights.id
}
