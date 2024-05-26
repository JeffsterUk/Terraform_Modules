/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Private DNS Zone Virtual Network Link.
  *
  */

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  provider              = azurerm.hub_subscription
  name                  = format("%s-%s", var.virtual_network_name, "link")
  private_dns_zone_name = var.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  tags                  = var.tags
  lifecycle {
    ignore_changes = [
      name,                 # To be investigated in Task21319
      resource_group_name,  # To be investigated in Task21319
      registration_enabled, # To be investigated in Task21319
      virtual_network_id    # To be investigated in Task21319
    ]
  }
}