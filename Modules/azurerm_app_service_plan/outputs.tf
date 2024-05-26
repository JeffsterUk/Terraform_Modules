output "id" {
  value       = azurerm_service_plan.service_plan.id
  description = "The ID of the App Service Plan."
}

output "name" {
  value       = azurerm_service_plan.service_plan.name
  description = "The name of the App Service Plan component."
}

output "service_plan" {
  value       = azurerm_service_plan.service_plan
  description = "Outputs the full attributes of the App Service Plan."
}
 