resource_group_name = "codewebifydev_group"
vnet_name           = "codewebify-vnet-east"
subnet_name         = "dev1"
vm_count            = 3
prefix              = "default"
vm_name             = "VtestVM"
vm_size             = "Standard_D8s_v5"
admin_username      = "adminuser"
admin_password      = "Adminpassword123@@@#####"
os_type             = "Linux"
image_publisher     = "Canonical"
image_offer         = "0001-com-ubuntu-server-jammy"
image_sku           = "22_04-lts"
image_version       = "latest"

nsg_rules = [
  {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
]

tags = {
  environment = "development"
  project     = "testproject"
}
