/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Management Group Policy Assignment.
  *
  */

resource "azurerm_management_group_policy_assignment" "mg-assignment" {
  name                 = var.mgpolicyassignment_name
  policy_definition_id = var.policy_id
  management_group_id  = "/providers/Microsoft.Management/managementgroups/${var.management_group_id}"
  description          = var.description
  display_name         = var.display_name
  enforce              = var.enforce
  location             = var.location
  not_scopes           = var.not_scopes
  parameters           = var.parameters

  metadata = <<METADATA
      {
      "category": "${var.category}"
      }
  METADATA

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_message

    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = policy_definition_reference_id.value.content
    }
  }

  dynamic "overrides" {
    for_each = var.overrides

    content {
      value = overrides.value.content
      dynamic "selectors" {
        for_each = overrides.value.selectors != null ? [overrides.value.selectors] : []

        content {
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "resource_selectors" {
    for_each = var.resource_selectors

    content {
      name = resource_selectors.value.content
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors != null ? [resource_selectors.value.selectors] : []

        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}

resource "azurerm_role_assignment" "policy_role_assignment" {
  for_each             = { for rd in var.role_definition_names : rd => rd }
  scope                = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  role_definition_name = each.key
  principal_id         = azurerm_management_group_policy_assignment.mg-assignment.identity[0].principal_id
}