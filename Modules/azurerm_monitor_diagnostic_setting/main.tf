/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Monitor Diagnostic Setting.
  *
  */

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                       = var.name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    iterator = log_category
    for_each = data.azurerm_monitor_diagnostic_categories.categories.log_category_types
    content {
      category = log_category.value
    }
  }

  dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.categories.metrics
    content {
      category = metric_category.value
    }
  }
}