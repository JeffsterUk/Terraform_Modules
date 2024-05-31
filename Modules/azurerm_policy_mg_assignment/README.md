<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Management Group Policy Assignment.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.mg-assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_role_assignment.policy_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_category"></a> [category](#input\_category) | category | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description which should be used for this Policy Assignment. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The Display Name for this Policy Assignment. | `string` | `null` | no |
| <a name="input_enforce"></a> [enforce](#input\_enforce) | Specifies if this Policy should be enforced or not? Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity has the following schema:<pre>[<br>  {<br>    type         = (Required) The Type of Managed Identity which should be added to this Policy Definition. Possible values are SystemAssigned or UserAssigned.<br>    identity_ids = (Optional) A list of User Managed Identity IDs which should be assigned to the Policy Definition. NOTE - This is required when type is set to UserAssigned.<br>  }<br>]</pre> | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created. | `string` | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The ID of the Management Group. Changing this forces a new Policy Assignment to be created. | `string` | n/a | yes |
| <a name="input_mgpolicyassignment_name"></a> [mgpolicyassignment\_name](#input\_mgpolicyassignment\_name) | The name which should be used for this Policy Assignment. Possible values must be between 3 and 24 characters in length. Changing this forces a new Policy Assignment to be created. | `string` | n/a | yes |
| <a name="input_non_compliance_message"></a> [non\_compliance\_message](#input\_non\_compliance\_message) | Non compliance message has the following schema:<pre>[<br>  {<br>    content                        = String (Required) The non-compliance message text. When assigning policy sets (initiatives), unless policy_definition_reference_id is specified then this message will be the default for all policies.<br>    policy_definition_reference_id = String (Optional) When assigning policy sets (initiatives), this is the ID of the policy definition that the non-compliance message applies to.<br>  }<br>]</pre> | <pre>list(object({<br>    content                        = string<br>    policy_definition_reference_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_not_scopes"></a> [not\_scopes](#input\_not\_scopes) | exclude resources or RG | `list(any)` | `null` | no |
| <a name="input_overrides"></a> [overrides](#input\_overrides) | Override has the following schema:<pre>[<br>  {<br>    value       = String (Required) Specifies the value to override the policy property. Possible values for policyEffect override listed policy effects.<br>    selectors   = list((objects{<br>          in     = optional(list) Specify the list of policy reference id values to filter in. NOTE -Cannot be used with not_in.<br>          not_in = optional(list) Specify the list of policy reference id values to filter out. NOTE -Cannot be used with in.    <br>    })) <br>  }<br>]</pre> | <pre>list(object({<br>    value = string<br>    selectors = optional(list(object({<br>      in     = optional(list(string))<br>      not_in = optional(list(string))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A JSON mapping of any Parameters for this Policy. | `string` | `null` | no |
| <a name="input_policy_id"></a> [policy\_id](#input\_policy\_id) | The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created. | `string` | n/a | yes |
| <a name="input_resource_selectors"></a> [resource\_selectors](#input\_resource\_selectors) | resource\_selectors has the following schema:<pre>[<br>  {<br>    name        = String (Optional) Specifies a name for the resource selector.<br>    selectors   = list((objects{<br>          kind   = (Required) Specifies which characteristic will narrow down the set of evaluated resources. Possible values are resourceLocation, resourceType and resourceWithoutLocation.<br>          in     = optional(list) Specify the list of policy reference id values to filter in. NOTE -Cannot be used with not_in.<br>          not_in = optional(list) Specify the list of policy reference id values to filter out. NOTE -Cannot be used with in.     <br>    }))<br>  }<br>]</pre> | <pre>list(object({<br>    name = optional(string)<br>    selectors = list(object({<br>      kind   = string<br>      in     = optional(list(string))<br>      not_in = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_role_definition_names"></a> [role\_definition\_names](#input\_role\_definition\_names) | n/a | `list(string)` | `[]` | no |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->