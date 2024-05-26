/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Route Table.
  *
  */

resource "azurerm_route_table" "table" {
  name                          = var.route_table_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                          = var.tags
}

resource "azurerm_route" "routes" {
  for_each               = { for route in toset(var.routes) : route.route_name => route }
  name                   = each.key
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.table.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
}