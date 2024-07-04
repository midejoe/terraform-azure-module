module "azure_vm" {
  source              = "./terraform-vm-module"
  resource_group_name = "ExistingResourceGroup"
  vnet_name           = "ExistingVNet"
  subnet_name         = "ExistingSubnet"
  vm_count            = 1
  prefix              = "devvm"
  vm_name             = "VigirniaVM"
  vm_size             = "Standard_D8s_v5"
  admin_username      = "adminuser"
  admin_password      = "Adminpassword123@@@#####"
  os_type             = "Linux" # or "Windows"
  image_publisher     = "RedHat"
  image_offer         = "RHEL"
  image_sku           = "7.9"
  image_version       = "latest"
  tags = {
    environment = "development"
    project     = "testproject"
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