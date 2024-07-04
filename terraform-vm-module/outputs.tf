# output "vm_id" {
#   description = "The ID of the virtual machine"
#   value       = var.os_type == "Linux" ? azurerm_linux_virtual_machine.linux_vm[0].id : azurerm_windows_virtual_machine.windows_vm[0].id
# }

# output "vm_private_ip" {
#   description = "The private IP address of the virtual machine"
#   value       = azurerm_network_interface.nic.private_ip_address
# }


output "vm_ids" {
  description = "The IDs of the virtual machines"
  value       = var.os_type == "Linux" ? azurerm_linux_virtual_machine.linux_vm[*].id : azurerm_windows_virtual_machine.windows_vm[*].id
}

output "vm_private_ips" {
  description = "The private IP addresses of the virtual machines"
  value       = azurerm_network_interface.nic[*].private_ip_address
}
