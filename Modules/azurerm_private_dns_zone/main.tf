/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private DNS Zone.
  *
  */

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
  dynamic "soa_record" {
    for_each = var.update_soarecord ? [1] : []
    content {
      email        = var.email
      expire_time  = var.expire_time
      minimum_ttl  = var.minimum_ttl
      refresh_time = var.refresh_time
      retry_time   = var.retry_time
      ttl          = var.ttl
      tags         = var.tags
    }
  }
}

module "azurerm_private_dns_zone_virtual_network_links" {
  source    = "../azurerm_private_dns_zone_virtual_network_link"
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  for_each  = { for virtual_network in data.azurerm_virtual_network.vnet : virtual_network.name => virtual_network }

  virtual_network_name  = each.key
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = each.value.id
  tags                  = var.tags
}