# Module: subnet/outputs.tf

output "id" {
  description = "The ID of the existing subnet"
  value       = azurerm_subnet.subnet.id
}