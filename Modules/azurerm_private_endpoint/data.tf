data "azurerm_private_dns_zone" "private_dns_zone" {
  provider = azurerm.hub_subscription
  count    = var.private_dns_zone_name != "" ? 1 : 0

  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
}