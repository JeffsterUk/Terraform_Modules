/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Policy Initiative.
  *
  */

resource "azurerm_policy_set_definition" "az_initiative" {
  name         = var.initiativeName
  policy_type  = var.policyType
  display_name = var.initiativeDisplayName
  description  = var.initiativeDescription

  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.managementGroupId}"

  parameters = var.parameters

  metadata = <<METADATA
    {
    "category": "${var.policysetDefinitionCategory}"
    }
METADATA

  dynamic "policy_definition_reference" {
    for_each = var.policy_definition_reference

    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      parameter_values     = policy_definition_reference.value.parameter_values
      reference_id         = policy_definition_reference.value.reference_id
      policy_group_names   = policy_definition_reference.value.policy_group_names
    }
  }
}