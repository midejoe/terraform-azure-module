# module "azure_vm" {
#   source              = "./terraform-vm-module"
#   resource_group_name = "adewale"
#   vnet_name           = "Terraform-vnet"
#   subnet_name         = "Terraform-subnet"
#   vm_count            = 1
#   prefix              = "devvm"
#   vm_name             = "VtestVM"
#   vm_size             = "Standard_D8s_v5"
#   admin_username      = "adminuser"
#   admin_password      = "Adminpassword123@@@#####"
#   os_type             = "Linux" # or "Windows"
#   image_publisher     = "RedHat"
#   image_offer         = "RHEL"
#   image_sku           = "7.9"
#   image_version       = "latest"
#   tags = {
#     environment = "development"
#     project     = "testproject"
#   }
#   nsg_rules = [
#     {
#       name                      = "AllowSSH"
#       priority                  = 1000
#       direction                 = "Inbound"
#       access                    = "Allow"
#       protocol                  = "Tcp"
#       source_port_range         = "*"
#       destination_port_range    = "22"
#       source_address_prefix     = "*"
#       destination_address_prefix = "*"
#     },
#   ]
# }

module "azure_vm" {
  source              = "./terraform-vm-module"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  vm_count            = var.vm_count
  prefix              = var.prefix
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  os_type             = var.os_type
  image_publisher     = var.image_publisher
  image_offer         = var.image_offer
  image_sku           = var.image_sku
  image_version       = var.image_version
  tags                = var.tags
  nsg_rules           = var.nsg_rules
}
