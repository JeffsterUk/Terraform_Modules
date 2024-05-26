/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Logic App (Consumption or Standard).
  *
  */

resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  count               = var.logic_app_type == "consumption" ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      workflow_parameters, # Managed by App Team
      parameters,          # Managed by App Team
      enabled,             # Managed by App Team
      tags["displayName"]  # Managed by App Team
    ]
  }
}

resource "azurerm_logic_app_standard" "logic_app_standard" {
  count                      = var.logic_app_type == "standard" ? 1 : 0
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  version                    = var.runtime_version
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  storage_account_share_name = var.storage_account_share_name
  virtual_network_subnet_id  = var.virtual_network_subnet_id
  app_settings               = var.app_settings
  site_config {
    always_on                        = var.site_config.always_on
    runtime_scale_monitoring_enabled = var.site_config.runtime_scale_monitoring_enabled
    public_network_access_enabled    = var.site_config.public_network_access_enabled
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
  tags = var.tags
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = var.logic_app_type == "standard" ? azurerm_logic_app_standard.logic_app_standard[0].id : azurerm_logic_app_workflow.logic_app_workflow[0].id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

module "logic_app_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_logic_app_standard.logic_app_standard[0].id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = each.value.subresource_names
  private_dns_zone_name                = each.value.private_dns_zone_name
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
  tags                                 = each.value.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}