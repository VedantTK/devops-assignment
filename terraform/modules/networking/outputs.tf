output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "subnet_functions_id" {
  value = azurerm_subnet.functions.id
}
output "subnet_data_id" {
  value = azurerm_subnet.data.id
}
output "subnet_shared_id" {
  value = azurerm_subnet.shared.id
}
