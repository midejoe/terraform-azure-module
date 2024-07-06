# Module: resource_group/main.tf

data "azurerm_resource_group" "rg" {
  name = var.name
}