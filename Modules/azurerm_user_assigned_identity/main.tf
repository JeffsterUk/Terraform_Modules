/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a User Assigned Identity.
  *
  */

resource "azurerm_user_assigned_identity" "this" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_role_assignment" "this" {
  for_each             = var.role_assignments
  scope                = each.value.scope_id
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  lifecycle {
    ignore_changes = [ scope ]
  }
}

resource "azurerm_federated_identity_credential" "this" {
  for_each            = { for a in var.federated_identity_credentials : a.name => a }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  audience            = each.value.audience
  issuer              = each.value.issuer
  parent_id           = azurerm_user_assigned_identity.this.id
  subject             = each.value.subject
}
