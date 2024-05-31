/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private DNS Zone Virtual Network Link.
  *
  */

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  provider              = azurerm.hub_subscription
  name                  = var.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  tags                  = var.tags
}