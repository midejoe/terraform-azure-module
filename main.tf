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

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.86.0"
    }
  }
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "adewale" 
#     storage_account_name = "taplatazgvsaappterraform"                      
#     container_name       = "tf-state-files"              
#     key                  = " terraform.tfstate"
#   }
# }

# Module for using an existing resource group
module "resource_group" {
  source = "./terraform-vm-module/modules/resource_group"
  name   = var.resource_group_name
}

# Module for using an existing virtual network
module "vnet" {
  source              = "./terraform-vm-module/modules/virtual_network"
  resource_group_name = var.resource_group_name
  name                = var.vnet_name
}

# Module for using an existing subnet
module "subnet" {
  source              = "./terraform-vm-module/modules/subnet"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  name                = var.subnet_name
}

# Module for creating VMs

variable "azure_devops_url" {}
variable "azure_devops_pat" {}
variable azure_devops_pool" {}

module "azure_vm" {
  source              = "./terraform-vm-module/modules/virtual_machine"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  vm_count            = var.vm_count
  prefix              = var.prefix
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
  os_type             = var.os_type
  identity            = var.identity
  linux_image_publisher     = var.linux_image_publisher
  linux_image_offer         = var.linux_image_offer
  linux_image_sku           = var.linux_image_sku
  linux_image_version       = var.linux_image_version
  windows_image_publisher   = var.windows_image_publisher
  windows_image_offer       = var.windows_image_offer
  windows_image_sku         = var.windows_image_sku
  windows_image_version     = var.windows_image_version
  nsg_rules           = var.nsg_rules

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i '${self.public_ip_address},' --extra-vars "ansible_user=${var.admin_username} ansible_password=${var.admin_password} ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore azure_devops_url=${var.azure_devops_url} azure_devops_pat=${var.azure_devops_pat} azure_devops_pool=${var.azure_devops_pool}" ../install_tools.yml
    EOT
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

resource "azurerm_virtual_machine_extension" "winrm" {
  name                 = "enable-winrm"
  virtual_machine_id   = module.azure_vm[0].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"winrm quickconfig -q; winrm set winrm/config/winrs @{MaxMemoryPerShellMB=1024}; winrm set winrm/config @{MaxTimeoutms=1800000}; winrm set winrm/config/service @{AllowUnencrypted='true'}; winrm set winrm/config/service/auth @{Basic='true'}; sc config winrm start=auto; Start-Service winrm;\""
    }
  SETTINGS
}


