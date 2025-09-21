# Create Application Insights resource
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.project_name}-${var.environment}-ai"  # Unique name
  location            = var.location                                  # Azure region
  resource_group_name = var.resource_group_name
  application_type    = "web"                                         # Suitable for Function Apps
  retention_in_days   = 90                                            # Retention policy
  tags                = var.tags
}
