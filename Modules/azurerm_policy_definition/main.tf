/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Policy Definition.
  *
  */

resource "azurerm_policy_definition" "policy" {
  name                = var.policyname
  policy_type         = var.policy_type
  mode                = var.policymode
  display_name        = var.display_name
  description         = var.description
  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  metadata            = var.metadata
  policy_rule         = var.policy_rule
  parameters          = var.parameters
}