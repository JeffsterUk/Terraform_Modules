output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
  description = "The Log Analytics Workspace ID."
}

output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.name
  description = "The name of the Log Analytics Workspace."
}

output "log_analytics_workspace_customer_id" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
}

output "log_analytics_workspace_sku" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.sku
  description = "The SKU of the Log Analytics Workspace."
}

output "log_analytics_workspace_retention" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.retention_in_days
  description = "The Workspace data retention in days."
}

output "log_analytics_workspace_primary_shared_key" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  description = "The Primary shared key for the Log Analytics Workspace."
  sensitive   = true
}

output "log_analytics_workspace_secondary_shared_key" {
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.secondary_shared_key
  description = "The Secondary shared key for the Log Analytics Workspace."
  sensitive   = true
}
