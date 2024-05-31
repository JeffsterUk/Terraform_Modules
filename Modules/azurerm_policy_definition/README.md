<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Policy Definition.

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
| [azurerm_policy_definition.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the policy definition. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the policy definition. | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition. | `string` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. | `string` | `null` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | The policy type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policymode"></a> [policymode](#input\_policymode) | The policy resource manager mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data. | `string` | n/a | yes |
| <a name="input_policyname"></a> [policyname](#input\_policyname) | The name of the policy definition. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->