variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "prefix" {
  description = "Prefix for resources"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_name" {
  description = "The name of the virtual machine"
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
