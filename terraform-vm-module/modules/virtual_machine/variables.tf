variable "vm_count" {
  description = "The number of VMs to create"
  type        = number
}

variable "prefix" {
  description = "Prefix for resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}


variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username"
  type        = string
}

variable "admin_password" {
  description = "The admin password"
  type        = string
}

variable "linux_image_publisher" {
  description = "The image publisher"
  type        = string
}

variable "linux_image_offer" {
  description = "The image offer"
  type        = string
}

variable "linux_image_sku" {
  description = "The image SKU"
  type        = string
}

variable "linux_image_version" {
  description = "The image version"
  type        = string
}

variable "windows_image_publisher" {
  description = "The image publisher"
  type        = string
}

variable "windows_image_offer" {
  description = "The image offer"
  type        = string
}

variable "windows_image_sku" {
  description = "The image SKU"
  type        = string
}

variable "windows_image_version" {
  description = "The image version"
  type        = string
}

variable "os_type" {
  description = "The type of OS (Linux/Windows)"
  type        = string
}

variable "nsg_rules" {
  description = "Network Security Group rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

# variable "identity" {
#   type = object({
#     type         = string
#     identity_ids = optional(set(string))
#   })
#   default = {
#     type         = "SystemAssigned"
#     identity_ids = null
#   }
# }

# variable "aad_principal_id" {
#   description = "Azure AD principal ID to assign roles to"
#   type        = string
# }

# variable "azure_devops_url" {}
# variable "azure_devops_pat" {}
# variable "azure_devops_pool" {}