# Module: resource_group/outputs.tf

# output "name" {
#   description = "The name of the existing resource group"
#   value       = data.azurerm_resource_group.rg.name
# }

# output "location" {
#   description = "The location of the existing resource group"
#   value = data.azurerm_resource_group.rg.location
# }

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.rg.id
}