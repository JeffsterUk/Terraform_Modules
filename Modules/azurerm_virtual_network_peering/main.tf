/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Virtual Network Peering.
  *
  */

resource "azurerm_virtual_network_peering" "spoke_virtual_network_peering" {
  name                         = "${var.spoke_virtual_network_name}-to-${var.hub_virtual_network_name}"
  allow_forwarded_traffic      = var.spoke_allow_forwarded_traffic
  allow_gateway_transit        = var.spoke_allow_gateway_transit
  allow_virtual_network_access = var.spoke_allow_virtual_network_access
  remote_virtual_network_id    = "/subscriptions/${var.hub_subscription_id}/resourceGroups/${var.hub_virtual_network_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.hub_virtual_network_name}"
  resource_group_name          = var.spoke_virtual_network_resource_group_name
  virtual_network_name         = var.spoke_virtual_network_name
  use_remote_gateways          = var.spoke_use_remote_gateways
}

resource "azurerm_virtual_network_peering" "hub_virtual_network_peering" {
  provider                     = azurerm.hub_subscription
  name                         = "${var.hub_virtual_network_name}-to-${var.spoke_virtual_network_name}"
  allow_forwarded_traffic      = var.hub_allow_forwarded_traffic
  allow_gateway_transit        = var.hub_allow_gateway_transit
  allow_virtual_network_access = var.hub_allow_virtual_network_access
  remote_virtual_network_id    = "/subscriptions/${var.spoke_subscription_id}/resourceGroups/${var.spoke_virtual_network_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.spoke_virtual_network_name}"
  resource_group_name          = var.hub_virtual_network_resource_group_name
  virtual_network_name         = var.hub_virtual_network_name
  use_remote_gateways          = var.hub_use_remote_gateways
}