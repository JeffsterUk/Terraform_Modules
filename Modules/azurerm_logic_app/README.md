<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Logic App (Consumption or Standard).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logic_app_private_endpoints"></a> [logic\_app\_private\_endpoints](#module\_logic\_app\_private\_endpoints) | ../azurerm_private_endpoint | n/a |
| <a name="module_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#module\_monitor\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_logic_app_standard.logic_app_standard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |
| [azurerm_logic_app_workflow.logic_app_workflow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | The ID of the App Service Plan to use for the Logic App. | `string` | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of app settings to use for the Logic App. | `map(string)` | <pre>{<br>  "FUNCTIONS_WORKER_RUNTIME": "node",<br>  "WEBSITE_NODE_DEFAULT_VERSION": "~18"<br>}</pre> | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable Diagnostic Settings. | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Identities IDs to add to logic App. Mandatory if type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Add an Identity (MSI) to the logic app. Possible values are SystemAssigned or UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the Logic App should be created. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send Diagnostic to. | `string` | `null` | no |
| <a name="input_logic_app_type"></a> [logic\_app\_type](#input\_logic\_app\_type) | The type of Logic App to create. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Logic App. | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A private\_endpoints block supports the following:<br>&bull; `name` = string - The name of the Private Endpoint<br>&bull; `private_service_connection_name` = string - The name of the Private Service Connection.<br>&bull; `subnet_id` = string - The Subnet ID where this Network Interface should be located in.<br>&bull; `subresource_names` = string - A list of subresource names which the Private Endpoint is able to connect to. subresource\_names corresponds to group\_id.<br>&bull; `private_dns_zone_name` = string - Private DNS Zone Name<br>&bull; `private_dns_zone_resource_group_name` = string - Private DNS Zone Resource Group Name<br>&bull; `is_manual_connection` = bool - Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner. | <pre>list(object({<br>    name                                 = string<br>    private_service_connection_name      = string<br>    subnet_id                            = string<br>    subresource_names                    = list(string)<br>    private_dns_zone_name                = string<br>    private_dns_zone_resource_group_name = string<br>    is_manual_connection                 = bool<br>    tags                                 = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Logic App should be created. | `string` | n/a | yes |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | The runtime version associated with the Logic App. | `string` | `"~4"` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for Logic App - standard only. | <pre>object({<br>    always_on                        = bool<br>    runtime_scale_monitoring_enabled = bool<br>    public_network_access_enabled    = bool<br>  })</pre> | <pre>{<br>  "always_on": true,<br>  "public_network_access_enabled": false,<br>  "runtime_scale_monitoring_enabled": true<br>}</pre> | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | The access key for the Storage Account to use for the Logic App. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the Storage Account to use for the Logic App. | `string` | `null` | no |
| <a name="input_storage_account_share_name"></a> [storage\_account\_share\_name](#input\_storage\_account\_share\_name) | The name of the Storage Account File Share to use for the Logic App. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The ID of the Virtual Network Subnet to use for the Logic App. | `string` | `null` | no |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->