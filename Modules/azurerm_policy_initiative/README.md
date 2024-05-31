<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Policy Initiative.

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
| [azurerm_policy_set_definition.az_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initiativeDescription"></a> [initiativeDescription](#input\_initiativeDescription) | initiativeDescription | `string` | n/a | yes |
| <a name="input_initiativeDisplayName"></a> [initiativeDisplayName](#input\_initiativeDisplayName) | initiativeDisplayName | `string` | n/a | yes |
| <a name="input_initiativeName"></a> [initiativeName](#input\_initiativeName) | initiativeName | `string` | n/a | yes |
| <a name="input_managementGroupId"></a> [managementGroupId](#input\_managementGroupId) | managementGroupId | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | parameters | `string` | `null` | no |
| <a name="input_policyType"></a> [policyType](#input\_policyType) | policyType | `string` | n/a | yes |
| <a name="input_policy_definition_reference"></a> [policy\_definition\_reference](#input\_policy\_definition\_reference) | n/a | <pre>list(object({<br>    policy_definition_id = string<br>    parameter_values     = optional(string, null)<br>    reference_id         = optional(string, null)<br>    policy_group_names   = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| <a name="input_policysetDefinitionCategory"></a> [policysetDefinitionCategory](#input\_policysetDefinitionCategory) | policysetDefinitionCategory | `string` | n/a | yes |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->