# Module: resource_group/outputs.tf

output "name" {
  description = "The name of the existing resource group"
  value       = data.azurerm_resource_group.rg.name
}

output "location" {
  description = "The location of the existing resource group"
  value = data.azurerm_resource_group.rg.location
}