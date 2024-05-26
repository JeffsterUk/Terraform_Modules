/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Storage Account.
  *
  */

resource "azurerm_storage_account" "storage_account" {
  name                            = lower(var.name)
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  access_tier                     = var.access_tier
  enable_https_traffic_only       = var.enable_https_traffic_only
  is_hns_enabled                  = var.hns_enabled
  min_tls_version                 = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  public_network_access_enabled   = var.public_network_access_enabled
  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action = network_rules.value.default_action
    }
  }
  queue_properties {
    dynamic "logging" {
      for_each = var.queue_properties_logging != null ? [var.queue_properties_logging] : []
      content {
        delete                = logging.value.delete
        read                  = logging.value.read
        write                 = logging.value.write
        version               = logging.value.version
        retention_policy_days = logging.value.retention_policy_days
      }
    }
  }
  tags = var.tags
}

module "storage_account_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_storage_account.storage_account.id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = each.value.subresource_names
  private_dns_zone_name                = each.value.private_dns_zone_name
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
  tags                                 = var.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}

resource "azurerm_storage_share" "storage_share" {
  for_each             = { for storage_share in var.storage_shares : storage_share.name => storage_share }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = each.value.quota
  depends_on           = [module.storage_account_private_endpoints]
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  for_each = var.enable_diagnostic_settings ? {
    sa    = azurerm_storage_account.storage_account.id
    blob  = "${azurerm_storage_account.storage_account.id}/blobServices/default/",
    file  = "${azurerm_storage_account.storage_account.id}/fileServices/default",
    queue = "${azurerm_storage_account.storage_account.id}/queueServices/default",
    table = "${azurerm_storage_account.storage_account.id}/tableServices/default",
  } : {}

  name                       = "${var.name}-${each.key}-DIAG-001"
  target_resource_id         = each.value
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
