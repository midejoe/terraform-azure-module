# resource "azurerm_network_interface" "nic" {
#   count               = var.vm_count
#   name                = "${var.prefix}-nic-${count.index}"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_security_group" "nsg" {
#   name                = "${var.prefix}-nsg"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_network_security_rule" "nsg_rule" {
#   count                      = length(var.nsg_rules)
#   name                       = var.nsg_rules[count.index].name
#   priority                   = var.nsg_rules[count.index].priority
#   direction                  = var.nsg_rules[count.index].direction
#   access                     = var.nsg_rules[count.index].access
#   protocol                   = var.nsg_rules[count.index].protocol
#   source_port_range          = var.nsg_rules[count.index].source_port_range
#   destination_port_range     = var.nsg_rules[count.index].destination_port_range
#   source_address_prefix      = var.nsg_rules[count.index].source_address_prefix
#   destination_address_prefix = var.nsg_rules[count.index].destination_address_prefix
#   resource_group_name        = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

# resource "azurerm_linux_virtual_machine" "linux_vm" {
#   count                 = var.os_type == "Linux" ? var.vm_count : 0
#   name                  = "${var.vm_name}-${count.index}"
#   location              = var.resource_group_location
#   resource_group_name   = var.resource_group_name
#   network_interface_ids = [azurerm_network_interface.nic[count.index].id]
#   size                  = var.vm_size
#   admin_username        = var.admin_username
#   admin_password        = var.admin_password

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = var.image_publisher
#     offer     = var.image_offer
#     sku       = var.image_sku
#     version   = var.image_version
#   }

#   computer_name                   = "${var.vm_name}-${count.index}"
#   disable_password_authentication = false

#   tags = var.tags
# }

# resource "azurerm_windows_virtual_machine" "windows_vm" {
#   count                 = var.os_type == "Windows" ? var.vm_count : 0
#   name                  = "${var.vm_name}-${count.index}"
#   location              = var.resource_group_location
#   resource_group_name   = var.resource_group_name
#   network_interface_ids = [azurerm_network_interface.nic[count.index].id]
#   size                  = var.vm_size
#   admin_username        = var.admin_username
#   admin_password        = var.admin_password

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = var.image_publisher
#     offer     = var.image_offer
#     sku       = var.image_sku
#     version   = var.image_version
#   }

#   computer_name            = "${var.vm_name}-${count.index}"
#   enable_automatic_updates = true

#   tags = var.tags
# }

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.prefix}-nic-${count.index}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "nsg_rule" {
  count                     = length(var.nsg_rules)
  name                      = var.nsg_rules[count.index].name
  priority                  = var.nsg_rules[count.index].priority
  direction                 = var.nsg_rules[count.index].direction
  access                    = var.nsg_rules[count.index].access
  protocol                  = var.nsg_rules[count.index].protocol
  source_port_range         = var.nsg_rules[count.index].source_port_range
  destination_port_range    = var.nsg_rules[count.index].destination_port_range
  source_address_prefix     = var.nsg_rules[count.index].source_address_prefix
  destination_address_prefix = var.nsg_rules[count.index].destination_address_prefix
  resource_group_name       = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#########################################################
############## Linux VM ###############################
#########################################################

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                 = var.os_type == "Linux" ? var.vm_count : 0
  name                  = "${var.vm_name}-${count.index}"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.linux_image_publisher
    offer     = var.linux_image_offer
    sku       = var.linux_image_sku
    version   = var.linux_image_version
  }

  #identity = var.identity

  computer_name                   = "${var.vm_name}-${count.index}"
  disable_password_authentication = false

  tags = var.tags
}

#####################################################
######## Linux VM extension for Entra ID ############
#####################################################

# resource "azurerm_virtual_machine_extension" "linux_aad_login" {
#   count               = var.os_type == "Linux" ? var.vm_count : 0
#   name                = "AADLoginForLinux"
#   virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[count.index].id
#   publisher           = "Microsoft.Azure.ActiveDirectory"
#   type                = "AADLoginForLinux"
#   type_handler_version = "1.0"
#   auto_upgrade_minor_version = true

#   depends_on          = [azurerm_windows_virtual_machine.linux_vm]
# }



#########################################################
############## Windows VM ###############################
#########################################################

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.os_type == "Windows" ? var.vm_count : 0
  name                  = "${var.vm_name}-${count.index}"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.windows_image_publisher
    offer     = var.windows_image_offer
    sku       = var.windows_image_sku
    version   = var.windows_image_version
  }

  computer_name            = "${var.vm_name}-${count.index}"
  enable_automatic_updates = true

  tags = var.tags

}

resource "null_resource" "wait_for_winrm" {
  count = var.os_type == "Windows" ? var.vm_count : 0

  depends_on = [azurerm_windows_virtual_machine.windows_vm, azurerm_virtual_machine_extension.winrm]

  provisioner "remote-exec" {
    inline = [
      "sleep 60", # Adjust sleep duration as needed
      "echo WinRM is configured and VM is ready"
    ]

    connection {
      type        = "winrm"
      user        = var.admin_username
      password    = var.admin_password
      host        = azurerm_network_interface.nic[count.index].private_ip_address
      https       = true
      port        = 5986
      insecure    = true
    }
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -File ${path.module}/../../install_ansible_on_vm.ps1",
      "ansible-playbook -i 'localhost,' --extra-vars 'ansible_user=${var.admin_username} ansible_password=${var.admin_password} ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore' ${path.module}/../../install_tools.yml"
    ]

    connection {
      type        = "winrm"
      user        = var.admin_username
      password    = var.admin_password
      host        = azurerm_network_interface.nic[count.index].private_ip_address
      https       = true
      port        = 5986
      insecure    = true
    }
  }
}

resource "azurerm_virtual_machine_extension" "winrm" {
  count                = var.os_type == "Windows" ? var.vm_count : 0
  name                 = "enable-winrm-${count.index}"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"winrm quickconfig -q; winrm set winrm/config/winrs @{MaxMemoryPerShellMB=1024}; winrm set winrm/config @{MaxTimeoutms=1800000}; winrm set winrm/config/service @{AllowUnencrypted='true'}; winrm set winrm/config/service/auth @{Basic='true'}; sc config winrm start=auto; Start-Service winrm;\""
    }
  SETTINGS
}


#####################################################
######## Windows VM extension for Entra ID ############
#####################################################

# resource "azurerm_virtual_machine_extension" "windows_aad_login" {
#   count               = var.os_type == "Windows" ? var.vm_count : 0
#   name                = "AADLoginForWindows"
#   virtual_machine_id  = azurerm_windows_virtual_machine.windows_vm[count.index].id
#   publisher           = "Microsoft.Azure.ActiveDirectory"
#   type                = "AADLoginForWindows"
#   type_handler_version = "1.0"
#   auto_upgrade_minor_version = true

#   depends_on          = [azurerm_windows_virtual_machine.windows_vm]
# }



# #######################################################
# ########## Role assignments for VMs ###################
# #######################################################


# resource "azurerm_role_assignment" "vm_aad_role_assignment" {
#   count = var.vm_count

#   scope                = azurerm_linux_virtual_machine.linux_vm[count.index].id != "" ? azurerm_linux_virtual_machine.linux_vm[count.index].id : azurerm_windows_virtual_machine.windows_vm[count.index].id
#   role_definition_name = "Virtual Machine Administrator Login"
#   principal_id         = var.aad_principal_id

#   depends_on = [
#     azurerm_linux_virtual_machine.linux_vm,
#     azurerm_windows_virtual_machine.windows_vm
#   ]
# }

# resource "azurerm_role_assignment" "vm_aad_login_role_assignment" {
#   count = var.vm_count

#   scope                = azurerm_linux_virtual_machine.linux_vm[count.index].id != "" ? azurerm_linux_virtual_machine.linux_vm[count.index].id : azurerm_windows_virtual_machine.windows_vm[count.index].id
#   role_definition_name = "Virtual Machine User Login"
#   principal_id         = var.aad_principal_id

#   depends_on = [
#     azurerm_linux_virtual_machine.linux_vm,
#     azurerm_windows_virtual_machine.windows_vm
#   ]
# }