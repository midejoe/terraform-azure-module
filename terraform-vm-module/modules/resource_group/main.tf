# Module: resource_group/main.tf

# data "azurerm_resource_group" "rg" {
#   name = var.name
# }

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}