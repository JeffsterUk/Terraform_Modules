/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private Endpoint.
  *
  */

resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = var.private_service_connection.name
    private_connection_resource_id = var.private_service_connection.private_connection_resource_id
    is_manual_connection           = var.private_service_connection.is_manual_connection
    subresource_names              = var.private_service_connection.subresource_names
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != "" ? [var.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value["name"]
      private_dns_zone_ids = private_dns_zone_group.value["private_dns_zone_ids"]
    }
  }
}

module "diagnostic_settings" {
  count                      = var.diagnostic_settings.log_analytics_workspace_id == null ? 0 : 1
  source                     = "../azurerm_monitor_diagnostic_setting"
  name                       = var.diagnostic_settings.name
  target_resource_id         = azurerm_private_endpoint.this.network_interface[0].id
  log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
}