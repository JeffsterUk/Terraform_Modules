/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a API Connection.
  *
  */

resource "azurerm_api_connection" "api_connection" {
  name                = var.name
  resource_group_name = var.resource_group_name
  managed_api_id      = data.azurerm_managed_api.managed_api.id
  tags                = var.tags
}