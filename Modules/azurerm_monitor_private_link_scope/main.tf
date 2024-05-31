#######################################################################
#                          Private Link Scope                         #
#######################################################################
resource "azurerm_monitor_private_link_scope" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_endpoint" "this" {
  name                          = var.private_endpoint.name
  location                      = var.private_endpoint.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.private_endpoint.subnet_id
  custom_network_interface_name = var.private_endpoint.custom_network_interface_name

  private_service_connection {
    name                           = var.private_endpoint.private_service_connection_name
    private_connection_resource_id = azurerm_monitor_private_link_scope.this.id
    is_manual_connection           = false
    subresource_names              = ["azuremonitor"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = var.private_endpoint.private_dns_zone_ids
  }
  tags = var.tags
}

resource "azurerm_monitor_private_link_scoped_service" "this" {
  for_each            = { for scoped_service in var.scoped_services : scoped_service.name => scoped_service }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = each.value.id
}