/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a DDoS Protection Plan.
  *
  */

resource "azurerm_network_ddos_protection_plan" "azurerm_ddos_plan" {
  name                = var.ddos_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}