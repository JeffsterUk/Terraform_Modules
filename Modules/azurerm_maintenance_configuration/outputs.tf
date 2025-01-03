output "maintenance_configuration_id" {
  value       = azurerm_maintenance_configuration.maintenance_configuration.id
  description = "The ID of the Maintenance Configuration"
}

output "maintenance_configuration_name" {
  value       = azurerm_maintenance_configuration.maintenance_configuration.name
  description = "The name of the Maintentance Configuration"
}

output "maintenance_assignment_dynamic_scope_id" {
  value       = azurerm_maintenance_assignment_dynamic_scope.maintenance_assignment_dynamic_scope[0].id
  description = "The ID of the Maintenance Assignment Dynamic Scope"
}
