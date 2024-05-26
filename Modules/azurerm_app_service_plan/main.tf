/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a App Service Plan.
  *
  */

resource "azurerm_service_plan" "service_plan" {
  name                         = var.name
  location                     = var.location
  os_type                      = var.os_type
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  app_service_environment_id   = var.app_service_environment_id
  maximum_elastic_worker_count = var.sku_name == "WS1" ? var.maximum_elastic_worker_count : null
  worker_count                 = var.sku_name != "WS1" ? var.worker_count : null #Set worker_count when sku is other than WS1. worker_count is not applicable to WS1 SKU
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_service_plan.service_plan.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
