resource_group_name = "test-rg"
location            = "Central US"

#vnet values
vnet_name      = "testvnet"
address_space  = ["10.0.0.0/16"]
subnet_name    = "default-sub"
address_prefix = "10.0.1.0/24"


vm_count       = 1
prefix         = "default"
vm_name        = "VtestVM"
vm_size        = "Standard_D8s_v5"
admin_username = "adminuser"
admin_password = "Adminpassword123@@@#####"
os_type        = "Windows"
sku_name       = "cis-windows-server-2022-l2-gen2"
offer_name     = "cis-windows-server-2022-l2"


publisher_name          = "center-for-internet-security-inc"
linux_image_publisher   = "center-for-internet-security-inc"
linux_image_offer       = "cis-rhel9-l1"
linux_image_sku         = "cis-rhel9-l1-gen2"
linux_image_version     = "1.0.15"
windows_image_publisher = "center-for-internet-security-inc"
windows_image_offer     = "cis-windows-server-2022-l2"
windows_image_sku       = "cis-windows-server-2022-l2-gen2"
windows_image_version   = "2.0.10"

#  windows_image_publisher   = "MicrosoftWindowsServer"
#  windows_image_offer       = "WindowsServer"
#  windows_image_sku         = "2019-Datacenter"
#  windows_image_version     = "latest"

nsg_rules = [
  {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allowansible"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },

]



tags = {
  environment = "development"
  project     = "testproject"
}
