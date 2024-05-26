output "id" {
  value       = azurerm_public_ip.pip.id
  description = "The Public IP ID."
}

output "name" {
  value       = azurerm_public_ip.pip.name
  description = " Specifies the name of the Public IP resource."
}

output "fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "Fully qualified domain name of the A DNS record associated with the public IP."
}

output "ip_address" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The IP address value that was allocated."
}