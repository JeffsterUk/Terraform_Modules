/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a SQL Server.
  *
  */

resource "random_password" "password" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "password" {
  name            = "${var.sql_server_name}-pwd"
  value           = random_password.password.result
  key_vault_id    = var.keyvault_id
  content_type    = "password"
  expiration_date = "2027-10-07T00:00:00Z"
}

resource "azurerm_mssql_server" "sql_server" {
  name                                 = var.sql_server_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = var.sql_version
  administrator_login                  = var.administrator_login
  administrator_login_password         = azurerm_key_vault_secret.password.value
  minimum_tls_version                  = var.minimum_tls_version
  connection_policy                    = var.connection_policy
  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled
  tags                                 = var.tags
  primary_user_assigned_identity_id    = var.primary_user_assigned_identity_id

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []
    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = azuread_administrator.value.object_id
      tenant_id                   = azuread_administrator.value.tenant_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }
  }
}

resource "azurerm_mssql_outbound_firewall_rule" "outbound_fw_rule" {
  name      = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  server_id = azurerm_mssql_server.sql_server.id
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditing_policy" {
  server_id              = azurerm_mssql_server.sql_server.id
  log_monitoring_enabled = true
}

module "private_endpoints" {
  providers                            = { azurerm.hub_subscription = azurerm.hub_subscription }
  source                               = "../azurerm_private_endpoint"
  for_each                             = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }
  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_mssql_server.sql_server.id
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

  name                       = "${var.sql_server_name}-DIAG-001"
  target_resource_id         = azurerm_mssql_server.sql_server.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

module "monitor_diagnostic_settings_db" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.sql_server_name}-AUDIT-001"
  target_resource_id         = "${azurerm_mssql_server.sql_server.id}/databases/master"
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

/*
TODO: Remove Below Code
resource "azurerm_monitor_diagnostic_setting" "audit_logs" {
  name                       = "${var.sql_server_name}-AUDIT-001"
  target_resource_id         = "${azurerm_mssql_server.sql_server.id}/databases/master"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "SQLSecurityAuditEvents"
  }
  enabled_log {
    category = "AutomaticTuning"
  }
  enabled_log {
    category = "Blocks"
  }
  enabled_log {
    category = "DatabaseWaitStatistics"
  }
  enabled_log {
    category = "Deadlocks"
  }
  enabled_log {
    category = "Deadlocks"
  }
  enabled_log {
    category = "DevOpsOperationsAudit"
  }
  enabled_log {
    category = "Errors"
  }
  enabled_log {
    category = "QueryStoreRuntimeStatistics"
  }
  enabled_log {
    category = "QueryStoreWaitStatistics"
  }
  enabled_log {
    category = "SQLInsights"
  }
  enabled_log {
    category = "Timeouts"
  }

  metric {
    category = "Basic"
  }
  metric {
    category = "InstanceAndAppAdvanced"
  }
  metric {
    category = "WorkloadManagement"
  }
}
*/