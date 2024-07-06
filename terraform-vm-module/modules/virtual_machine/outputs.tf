output "linux_vm_ids" {
  value = azurerm_linux_virtual_machine.linux_vm.*.id
}

output "windows_vm_ids" {
  value = azurerm_windows_virtual_machine.windows_vm.*.id
}

output "nic_ids" {
  value = azurerm_network_interface.nic.*.id
}
