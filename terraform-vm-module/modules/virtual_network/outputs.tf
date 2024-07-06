# Module: vnet/outputs.tf

output "name" {
  description = "The name of the existing virtual network"
  value       = data.azurerm_virtual_network.vnet.name
}