data "azurerm_virtual_network" "vnet" {
  for_each            = { for virtual_network in var.virtual_networks : virtual_network.name => virtual_network }
  name                = each.key
  resource_group_name = each.value.resource_group_name
}