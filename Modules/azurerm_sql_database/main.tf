/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a SQL Database. 
  *
  */

resource "azurerm_mssql_database" "sql_database" {
  name                        = var.database_name
  server_id                   = var.server_id
  collation                   = var.collation
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  elastic_pool_id             = var.elastic_pool_id
  geo_backup_enabled          = var.geo_backup_enabled
  license_type                = var.license_type
  max_size_gb                 = var.max_size_gb
  min_capacity                = var.min_capacity
  restore_point_in_time       = var.restore_point_in_time
  recover_database_id         = var.recover_database_id
  restore_dropped_database_id = var.restore_dropped_database_id
  read_replica_count          = var.read_replica_count
  read_scale                  = var.read_scale
  sample_name                 = var.sample_name
  sku_name                    = var.sku_name
  storage_account_type        = var.storage_account_type
  zone_redundant              = var.zone_redundant
  tags                        = var.tags

  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? [var.long_term_retention_policy] : []
    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy != null ? [var.short_term_retention_policy] : []
    content {
      retention_days = short_term_retention_policy.value.retention_days
    }
  }
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.database_name}-DIAG-001"
  target_resource_id         = azurerm_mssql_database.sql_database.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}