# Assign Admin Role to a specific Azure AD user/service principal
resource "azurerm_role_assignment" "admin" {
  scope                = var.resource_group_id   # Assign at Resource Group level
  role_definition_name = "Owner"                 # Full admin permissions
  principal_id         = var.admin_object_id     # Azure AD Object ID of Admin
}

# Assign Developer Role to a specific Azure AD user/service principal
resource "azurerm_role_assignment" "developer" {
  scope                = var.resource_group_id
  role_definition_name = "Contributor"           # Developer-level permissions
  principal_id         = var.dev_object_id
}
