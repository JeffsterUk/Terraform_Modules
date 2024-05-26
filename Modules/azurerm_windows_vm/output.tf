output "id" {
  value       = azurerm_windows_virtual_machine.vm.id
  description = "The ID of the Windows Virtual Machine."
}

output "name" {
  value       = azurerm_windows_virtual_machine.vm.name
  description = "The name of the Windows Virtual Machine."
}

output "resource_group_name" {
  value       = azurerm_windows_virtual_machine.vm.resource_group_name
  description = "The name of the Windows Virtual Machine."
}

output "private_ip_address" {
  value       = azurerm_windows_virtual_machine.vm.private_ip_address
  description = "The Primary Private IP Address assigned to this Virtual Machine."
}

output "public_ip_address" {
  value       = azurerm_windows_virtual_machine.vm.public_ip_address
  description = "The Primary Public IP Address assigned to this Virtual Machine."
}

output "public_ip_addresses" {
  value       = azurerm_windows_virtual_machine.vm.public_ip_addresses
  description = "A list of the Public IP Addresses assigned to this Virtual Machine."
}

output "virtual_machine_id" {
  value       = azurerm_windows_virtual_machine.vm.virtual_machine_id
  description = "A 128-bit identifier which uniquely identifies this Virtual Machine."
}

output "identity" {
  value       = azurerm_windows_virtual_machine.vm.identity
  description = <<-EOT
        An identity block exports the following:
        ```
        {
            principal_id - The ID of the System Managed Service Principal.
            tenant_id    - The ID of the Tenant the System Managed Service Principal is assigned in.
        }
        ```
    EOT
}

output "disks" {
  value = {
    for disk in azurerm_managed_disk.disk : disk.name => {
      id                   = disk.id
      name                 = disk.name
      storage_account_type = disk.storage_account_type
      disk_size_gb         = disk.disk_size_gb
    }
  }

  description = "A list of managed disks attached to the Virtual Machine and their properties."
}

output "network_interfaces" {
  value = {
    for nic in azurerm_network_interface.nic : nic.name => {
      id                   = nic.id
      name                 = nic.name
      private_ip_address   = nic.private_ip_address
      private_ip_addresses = nic.private_ip_addresses
    }
  }

  description = "A list of network interfaces attached to the Virtual Machine and their properties."
}