output "vm_id" {
  description = "Virtual machine id created."
  value       = azurerm_virtual_machine.vm.id
}

output "network_interface_ids" {
  description = "ids of the vm nics provisoned."
  value       = azurerm_network_interface.nic.id
}

output "network_interface_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = azurerm_network_interface.nic.private_ip_address
}