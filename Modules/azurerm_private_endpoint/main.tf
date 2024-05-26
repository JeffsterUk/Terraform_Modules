/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private Endpoint.
  *
  */

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags
  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names
  }
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_name != "" ? [1] : []
    content {
      name                 = var.private_dns_zone_name
      private_dns_zone_ids = [data.azurerm_private_dns_zone.private_dns_zone[0].id]
    }
  }
}

module "monitor_diagnostic_settings_nic" {
  count                      = var.enable_diagnostic_settings ? 1 : 0
  source                     = "../azurerm_monitor_diagnostic_setting"
  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_private_endpoint.private_endpoint.network_interface[0].id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}