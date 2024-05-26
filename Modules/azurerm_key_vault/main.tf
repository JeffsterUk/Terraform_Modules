/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Key Vault. 
  *
  */

resource "azurerm_key_vault" "vault" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  public_network_access_enabled   = var.public_network_access_enabled
  tags                            = var.tags

  dynamic "access_policy" {
    for_each = var.access_policy

    content {
      tenant_id               = access_policy.value.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }

  }

  dynamic "contact" {
    for_each = var.contact

    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }
}

module "key_vault_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_key_vault.vault.id
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

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_key_vault.vault.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
