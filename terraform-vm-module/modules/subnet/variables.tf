# Module: subnet/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "The name of the existing virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the existing subnet"
  type        = string
}

variable "address_prefix" {
  description = "cidr block of subnet"
  type        = string
}
