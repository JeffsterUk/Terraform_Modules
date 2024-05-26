/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Network Watcher Flow Log.
  *
  */

resource "azurerm_network_watcher_flow_log" "flow_logs" {
  name                      = "${var.nsgname}-nsg-flowlogs"
  network_watcher_name      = var.network_watcher_name
  resource_group_name       = var.resource_group_name
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.network_watcher_name}"
  storage_account_id        = var.storage_account_id
  enabled                   = var.enabled
  location                  = var.location
  version                   = var.version1

  dynamic "retention_policy" {
    for_each = var.retention_policy
    iterator = r

    content {
      enabled = r.value.enabled
      days    = r.value.days
    }
  }

  dynamic "traffic_analytics" {
    for_each = var.traffic_analytics
    iterator = t
    content {
      enabled               = t.value.enabled
      workspace_id          = t.value.workspace_id
      workspace_region      = t.value.workspace_region
      workspace_resource_id = t.value.workspace_resource_id
      interval_in_minutes   = t.value.interval_in_minutes
    }
  }
}