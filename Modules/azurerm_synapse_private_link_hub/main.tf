/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Synapse Private Link Hub.
  *
  */

resource "azurerm_synapse_private_link_hub" "synapse_private_link_hub" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "synapse_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"

  name                                 = "${var.name}-PE-001"
  private_service_connection_name      = "${var.name}-PE-001-PSC-001"
  subnet_id                            = var.subnet_id
  is_manual_connection                 = "false"
  location                             = var.location
  private_connection_resource_id       = azurerm_synapse_private_link_hub.synapse_private_link_hub.id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = ["Web"]
  private_dns_zone_name                = var.private_dns_zone_name
  private_dns_zone_resource_group_name = var.private_dns_zone_resource_group_name
  tags                                 = var.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}