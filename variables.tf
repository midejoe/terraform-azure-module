variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet within the virtual network"
  type        = string
}

variable "vm_count" {
  description = "Number of virtual machines to create"
  type        = number
}

variable "prefix" {
  description = "Prefix for naming resources (e.g., devvm)"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Username for the virtual machine's administrator"
  type        = string
}

variable "admin_password" {
  description = "Password for the virtual machine's administrator"
  type        = string
}

variable "os_type" {
  description = "Operating system type ('Linux' or 'Windows')"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the virtual machine image"
  type        = string
}

variable "image_offer" {
  description = "Offer of the virtual machine image"
  type        = string
}

variable "image_sku" {
  description = "SKU (version) of the virtual machine image"
  type        = string
}

variable "image_version" {
  description = "Version of the virtual machine image"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    environment = "development"
    project     = "testproject"
  }
}

variable "nsg_rules" {
  description = "List of network security group rules"
  type        = list(object({
    name                      = string
    priority                  = number
    direction                 = string
    access                    = string
    protocol                  = string
    source_port_range         = string
    destination_port_range    = string
    source_address_prefix     = string
    destination_address_prefix= string
  }))
  default     = []
}
