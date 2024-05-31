<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Network Watcher Flow Log.

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
| [azurerm_network_watcher_flow_log.flow_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Should Network Flow Logging be Enabled? | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the Network Watcher Flow Log resides. | `string` | n/a | yes |
| <a name="input_network_watcher_name"></a> [network\_watcher\_name](#input\_network\_watcher\_name) | The name of the Network Watcher. | `string` | n/a | yes |
| <a name="input_nsgname"></a> [nsgname](#input\_nsgname) | The name of the Network Watcher. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Network Watcher was deployed. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | The schema for traffic\_analytics should look like this:<pre>[{<br>  enabled = bool   - (Required) Boolean flag to enable/disable retention.<br>  days    = number - (Required) The number of days to retain flow log records.<br>}]</pre>**NOTE**: If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list). | <pre>list(object({<br>    enabled = bool<br>    days    = number<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the Storage Account where flow logs are stored. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The id of subscription | `string` | n/a | yes |
| <a name="input_traffic_analytics"></a> [traffic\_analytics](#input\_traffic\_analytics) | The schema for traffic\_analytics should look like this:<pre>[{<br>  enabled               = bool   - (Required) Boolean flag to enable/disable traffic analytics.<br>  workspace_id          = string - (Required) The resource guid of the attached workspace.<br>  workspace_region      = string - (Required) The location of the attached workspace.<br>  workspace_resource_id = string - (Required) The resource ID of the attached workspace.<br>  interval_in_minutes   = number - (Optional) How frequently service should do flow analytics in minutes.<br>}]</pre>**NOTE**: If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list). | <pre>list(object({<br>    enabled               = bool<br>    workspace_id          = string<br>    workspace_region      = string<br>    workspace_resource_id = string<br>    interval_in_minutes   = number<br>  }))</pre> | `[]` | no |
| <a name="input_version1"></a> [version1](#input\_version1) | The version (version) of the flow log. Possible values are 1 and 2. | `number` | n/a | yes |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->