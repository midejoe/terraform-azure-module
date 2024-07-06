# Module: vnet/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "The name of the existing virtual network"
  type        = string
}
