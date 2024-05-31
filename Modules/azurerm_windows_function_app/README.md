<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Windows Function App.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_function_app_private_endpoints"></a> [function\_app\_private\_endpoints](#module\_function\_app\_private\_endpoints) | ../azurerm_private_endpoint | n/a |
| <a name="module_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#module\_monitor\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_windows_function_app.windows_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | The ID of the App Service Plan to use for the Function App. | `string` | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Function App application settings. | `map(string)` | `{}` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | Whether built-in logging is enabled. | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Whether the Function App uses client certificates. | `bool` | `null` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | The mode of the Function App's client certificates requirement for incoming requests. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. | `string` | `null` | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable Diagnostic Settings. | `bool` | `false` | no |
| <a name="input_function_app_version"></a> [function\_app\_version](#input\_function\_app\_version) | Version of the function app runtime to use. | `number` | `4` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Whether HTTPS traffic only is enabled. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | An object representing an Identity. <br><br>An Identity object adheres to the following schema:<pre>identity = {<br><br>  identity_type              = string       - (Required) Specifies the identity type of the Microsoft SQL Server. Currently, the only supported value is `SystemAssigned` (where Azure will generate a Service Principal for you).<br>  user_assigned_identity_ids = list(string) - (Optional) Specifies a list of User Assigned Identity IDs to be assigned. Required if type is `UserAssigned`.<br><br>}<br><br>**NOTE**: An optional property that is not required must be explicitly set to `null`</pre> | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_ip_restriction"></a> [ip\_restriction](#input\_ip\_restriction) | IP restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction. | `any` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the Function App should be created. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send Diagnostic to. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Function App. | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A private\_endpoints block supports the following:<br>&bull; `name` = string - The name of the Private Endpoint<br>&bull; `private_service_connection_name` = string - The name of the Private Service Connection.<br>&bull; `subnet_id` = string - The Subnet ID where this Network Interface should be located in.<br>&bull; `subresource_names` = string - A list of subresource names which the Private Endpoint is able to connect to. subresource\_names corresponds to group\_id.<br>&bull; `private_dns_zone_name` = string - Private DNS Zone Name<br>&bull; `private_dns_zone_resource_group_name` = string - Private DNS Zone Resource Group Name<br>&bull; `is_manual_connection` = bool - Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner. | <pre>list(object({<br>    name                                 = string<br>    private_service_connection_name      = string<br>    subnet_id                            = string<br>    subresource_names                    = list(string)<br>    private_dns_zone_name                = string<br>    private_dns_zone_resource_group_name = string<br>    is_manual_connection                 = bool<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for the Function App. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Function App should be created. | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block. | `any` | `{}` | no |
| <a name="input_sticky_settings"></a> [sticky\_settings](#input\_sticky\_settings) | Lists of connection strings and app settings to prevent from swapping between slots. | <pre>object({<br>    app_setting_names       = optional(list(string))<br>    connection_string_names = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | The access key for the Storage Account to use for the Function App. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the Storage Account to use for the Function App. | `string` | `null` | no |
| <a name="input_storage_account_share_connection_string"></a> [storage\_account\_share\_connection\_string](#input\_storage\_account\_share\_connection\_string) | The connection string for the Storage Account File Share to use for the Function App. | `string` | n/a | yes |
| <a name="input_storage_account_share_name"></a> [storage\_account\_share\_name](#input\_storage\_account\_share\_name) | The name of the Storage Account File Share to use for the Function App. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The ID of the Virtual Network Subnet to use for the Function App. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_app_id"></a> [function\_app\_id](#output\_function\_app\_id) | n/a |

## Example
<!-- END_TF_DOCS -->