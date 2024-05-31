/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private DNS Zone.
  *
  */

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
  dynamic "soa_record" {
    for_each = var.soa_record == null ? [] : [1]
    content {
      email        = soa_record.email
      expire_time  = soa_record.expire_time
      minimum_ttl  = soa_record.minimum_ttl
      refresh_time = soa_record.refresh_time
      retry_time   = soa_record.retry_time
      ttl          = soa_record.ttl
      tags         = var.tags
    }
  }
}

module "virtual_network_links" {
  source    = "../azure_private_dns_zone_virtual_network_link"
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  for_each  = { for virtual_network_link in var.virtual_network_links : virtual_network_link.name => virtual_network_link }

  name                  = "${each.value.name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.virtual_network_id
  tags                  = var.tags
}