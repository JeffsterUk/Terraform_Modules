/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Synapse Workspace.
  *
  */

resource "azurerm_storage_data_lake_gen2_filesystem" "storage_data_lake" {
  name               = var.storage_data_lake_name
  storage_account_id = var.storage_account_id
}

resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.storage_data_lake.id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_login_password
  managed_virtual_network_enabled      = var.managed_virtual_network_enabled
  managed_resource_group_name          = var.managed_resource_group_name
  public_network_access_enabled        = var.public_network_access_enabled
  azuread_authentication_only          = var.azuread_authentication_only

  aad_admin {
    login     = var.azure_ad_admin_login
    object_id = var.object_id
    tenant_id = var.tenant_id
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
    }
  }

  tags = var.tags
}

resource "azurerm_synapse_firewall_rule" "synapse_firewall_rule" {
  for_each             = { for firewall_rule in var.firewall_rules : firewall_rule.rule_name => firewall_rule }
  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = each.value.start_ip_address
  end_ip_address       = each.value.end_ip_address
}

resource "azurerm_synapse_managed_private_endpoint" "synapse_managed_private_endpoint" {
  count                = var.managed_private_endpoint_name != null ? 1 : 0
  name                 = var.managed_private_endpoint_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  target_resource_id   = var.storage_account_id
  subresource_name     = "blob"
  depends_on           = [module.synapse_private_endpoints]
}

module "synapse_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_synapse_workspace.synapse_workspace.id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = each.value.subresource_names
  private_dns_zone_name                = each.value.private_dns_zone_name
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
  tags                                 = var.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.synapse_workspace_name}-DIAG-001"
  target_resource_id         = azurerm_synapse_workspace.synapse_workspace.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
