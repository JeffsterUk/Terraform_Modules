/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Windows Web App.
  *
  */

resource "azurerm_windows_web_app" "windows_web_app" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  service_plan_id                 = var.app_service_plan_id
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  public_network_access_enabled   = var.public_network_access_enabled
  https_only                      = var.https_only
  tags                            = var.tags
  key_vault_reference_identity_id = var.identity_ids[0]
  app_settings                    = var.app_settings

  site_config {}

  dynamic "sticky_settings" {
    for_each = var.sticky_settings[*]
    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
}

module "web_app_private_endpoint" {
  providers                            = { azurerm.hub_subscription = azurerm.hub_subscription }
  source                               = "../azurerm_private_endpoint"
  for_each                             = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }
  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_windows_web_app.windows_web_app.id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = each.value.subresource_names
  private_dns_zone_name                = each.value.private_dns_zone_name
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
  tags                                 = each.value.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_windows_web_app.windows_web_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}