resource_group_name = "codewebifydev_group"
vnet_name           = "codewebify-vnet-east"
subnet_name         = "dev1"
vm_count            = 3
prefix              = "default"
vm_name             = "VtestVM"
vm_size             = "Standard_D8s_v5"
admin_username      = "adminuser"
admin_password      = "Adminpassword123@@@#####"
os_type             = "Windows"
linux_image_publisher     = "center-for-internet-security-inc"
linux_image_offer         = "cis-rhel9-l1"
linux_image_sku           = "cis-rhel9-l1-gen2"
linux_image_version       = "1.0.15"
windows_image_publisher   = "center-for-internet-security-inc"
windows_image_offer       = "cis-windows-server-2019-v1-0-0-l2"
windows_image_sku         = "cis-ws2019-l2-vw-po"
windows_image_version     = "2.0.10"

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
