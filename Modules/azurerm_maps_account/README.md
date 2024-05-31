<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Maps Account.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.13.1, < 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_user_assigned_identity"></a> [user\_assigned\_identity](#module\_user\_assigned\_identity) | ../azurerm_user_assigned_identity | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.maps_account](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_local_authentication"></a> [disable\_local\_authentication](#input\_disable\_local\_authentication) | Specifies whether to disable local authentication for the Azure Maps Account. | `bool` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of the Azure Maps Account. Possible values are Gen1 and Gen2. | `string` | `"Gen2"` | no |
| <a name="input_maps_account_location"></a> [maps\_account\_location](#input\_maps\_account\_location) | The location of the Azure Maps Account. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Azure Maps Account. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the resource group in which to create the App Service Plan component. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the User Assigned Identity component. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the Azure Maps Account. Possible values are S0, S1 and G2. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_location"></a> [user\_assigned\_identity\_location](#input\_user\_assigned\_identity\_location) | The location of the user assigned identity. | `string` | n/a | yes |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | The name of the user assigned identity. | `string` | n/a | yes |
| <a name="input_user_assigned_identity_role_assignments"></a> [user\_assigned\_identity\_role\_assignments](#input\_user\_assigned\_identity\_role\_assignments) | A map of role assignments to assign to the Azure Maps Account. | <pre>map(object({<br>    scope_id             = string<br>    role_definition_name = string<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->