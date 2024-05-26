/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a User Assigned Identity.
  *
  */

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_role_assignment" "role_assignments" {
  for_each             = var.role_assignments
  scope                = each.value.scope_id
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}