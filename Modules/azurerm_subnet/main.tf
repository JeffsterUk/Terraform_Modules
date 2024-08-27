/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Subnet.
  *
  */

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
  private_endpoint_network_policies = var.private_endpoint_network_policies
  dynamic "delegation" {
    for_each = [for del in var.delegation : {
      servicename = del.servicename
      actions     = del.actions
    }]
    content {
      name = replace(delegation.value.servicename, "/", ".")
      service_delegation {
        name    = delegation.value.servicename
        actions = delegation.value.actions
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  count                     = var.nsg_details.is_nsg_subnet_association_required ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_details.nsg_id
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  count          = var.route_table_details.is_route_table_subnet_association_required ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_details.route_table_id
}