# Azure VM Module

This module creates multiple Linux and Windows virtual machines in an existing Azure resource group, virtual network, and subnet.

## Variables

- `resource_group_name`: The name of the resource group where resources will be created.
- `vm_name`: The name of the virtual machine.
- `vm_size`: Size of the virtual machines.
- `subnet_id`: The ID of the subnet within the virtual network.
- `vm_count`: Number of virtual machines to create.
- `prefix`: Prefix for naming resources.
- `os_type`: The type of operating system: Linux or Windows.
- `image_publisher`: Image publisher of the operating system.
- `image_offer`: Image offer of the operating system.
- `image_sku`: Image sku of the operating system
- `image_version"`: Image version of the operating system
- `admin_username`: Username for the virtual machine's administrator.
- `admin_password`: Password for the virtual machine's administrator.
- `tags`: Tags to apply to all resources.

## Outputs

- `linux_vm_ids`: The IDs of the created Linux virtual machines.
- `windows_vm_ids`: The IDs of the created Windows virtual machines.
- `nic_ids`: The IDs of the Network Interface Cards.

## Usage

```hcl
module "azure_vm" {
  source              = "./modules/azure_vm"
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.id
  linux_vm_count      = var.linux_vm_count
  windows_vm_count    = var.windows_vm_count
  prefix              = var.prefix
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
}
