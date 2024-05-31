/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Storage Account.
  *
  */

resource "azurerm_storage_account" "this" {
  name                            = var.name
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

  tags = var.tags
}

module "private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azure_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.value.name
  location                             = var.location
  resource_group_name                  = var.resource_group_name
  subnet_id                            = each.value.subnet_id

  private_service_connection           = {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = each.value.private_service_connection.subresource_names
  }

  private_dns_zone_group = {
    name                 = each.value.private_dns_zone_group.name
    private_dns_zone_ids = each.value.private_dns_zone_group.private_dns_zone_ids
  }

  diagnostic_settings = {
    name                       = var.diagnostic_settings.name
    log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
  }

  tags                                 = var.tags
}

resource "azurerm_storage_share" "this" {
  for_each             = { for storage_share in var.storage_shares : storage_share.name => storage_share }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.this.name
  quota                = each.value.quota
  depends_on           = [module.private_endpoints]
}

# module "diagnostic_settings" {
#   source = "../azurerm_monitor_diagnostic_setting"
#   for_each = var.diagnostic_settings.log_analytics_workspace_id == null ? {} : {
#     sa    = azurerm_storage_account.this.id
#     blob  = "${azurerm_storage_account.this.id}/blobServices/default/",
#     file  = "${azurerm_storage_account.this.id}/fileServices/default",
#     queue = "${azurerm_storage_account.this.id}/queueServices/default",
#     table = "${azurerm_storage_account.this.id}/tableServices/default",
#   }

#   name                       = "${var.name}-${each.key}-DIAG-001"
#   target_resource_id         = var.diagnostic_settings.name
#   log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
# }
