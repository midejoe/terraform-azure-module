variable "resource_group_name" {
  description = "The name of the existing resource group"
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

variable "prefix" {
  description = "Prefix for resources"
  type        = string
}

variable "vm_count" {
  description = "The number of virtual machines to create"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "The base name of the virtual machines"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "os_type" {
  description = "The OS type of the virtual machine (Linux or Windows)"
  type        = string
}

variable "image_publisher" {
  description = "The image publisher"
  type        = string
}

variable "image_offer" {
  description = "The image offer"
  type        = string
}

variable "image_sku" {
  description = "The image SKU"
  type        = string
}

variable "image_version" {
  description = "The image version"
  type        = string
  default     = "latest"
}

variable "nsg_rules" {
  description = "List of network security group rules"
  type = list(object({
    name                      = string
    priority                  = number
    direction                 = string
    access                    = string
    protocol                  = string
    source_port_range         = string
    destination_port_range    = string
    source_address_prefix     = string
    destination_address_prefix = string
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
