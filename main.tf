module "azure_vm" {
  source              = "./terraform-azure-module/terraform-vm-module"
  resource_group_name = "myResourceGroup"
  location            = "East US"
  prefix              = "vm"
  vm_name             = "testVM"
  vm_size             = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Adminpassword123@@@#####"
  os_type             = "Linux" # or "Windows"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  image_version       = "latest"
  tags = {
    environment = "development"
    project     = "myproject"
  }
  nsg_rules = [
    {
      name                      = "AllowSSH"
      priority                  = 1000
      direction                 = "Inbound"
      access                    = "Allow"
      protocol                  = "Tcp"
      source_port_range         = "*"
      destination_port_range    = "22"
      source_address_prefix     = "*"
      destination_address_prefix = "*"
    },
  ]
}