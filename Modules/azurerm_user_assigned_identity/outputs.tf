output "id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
  description = "The ID of the User Assigned Identity."
}

output "client_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.client_id
  description = "The ID of the app associated with the Identity."
}