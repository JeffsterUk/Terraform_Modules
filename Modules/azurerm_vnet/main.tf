/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Virtual Network.
  *
  */

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}