provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.prefix}-nic-${count.index}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
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
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name                   = "${var.vm_name}-${count.index}"
  disable_password_authentication = false

  tags = var.tags
}

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
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name            = "${var.vm_name}-${count.index}"
  enable_automatic_updates = true

  tags = var.tags
}
