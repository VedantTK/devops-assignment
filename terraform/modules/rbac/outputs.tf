output "admin_role_assignment_id" {
  value = azurerm_role_assignment.admin.id
}

output "developer_role_assignment_id" {
  value = azurerm_role_assignment.developer.id
}
