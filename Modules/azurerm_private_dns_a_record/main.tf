/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private DNS A Record.
  *
  */

resource "azurerm_private_dns_a_record" "private_dns_a_record" {
  name                = lower(var.dns_a_record_name)
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  records             = var.records
  ttl                 = var.ttl
  tags                = var.tags
}