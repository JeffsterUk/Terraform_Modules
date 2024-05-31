<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Synapse Workspace.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#module\_monitor\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |
| <a name="module_synapse_private_endpoints"></a> [synapse\_private\_endpoints](#module\_synapse\_private\_endpoints) | ../azurerm_private_endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_data_lake_gen2_filesystem.storage_data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_synapse_firewall_rule.synapse_firewall_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_managed_private_endpoint.synapse_managed_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_managed_private_endpoint) | resource |
| [azurerm_synapse_workspace.synapse_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_ad_admin_login"></a> [azure\_ad\_admin\_login](#input\_azure\_ad\_admin\_login) | The login name of the Azure AD Administrator of this Synapse Workspace. | `string` | `null` | no |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | Specifies whether or not Azure AD only authentication is allowed for the Synapse Workspace. | `bool` | `false` | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable Diagnostic Settings. | `bool` | `false` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | n/a | <pre>list(object({<br>    rule_name        = string<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `[]` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send Diagnostic to. | `string` | `null` | no |
| <a name="input_managed_private_endpoint_name"></a> [managed\_private\_endpoint\_name](#input\_managed\_private\_endpoint\_name) | Specifies the name which should be used for this Managed Private Endpoint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_managed_resource_group_name"></a> [managed\_resource\_group\_name](#input\_managed\_resource\_group\_name) | The name of the managed resource group for the Synapse Workspace. | `string` | `null` | no |
| <a name="input_managed_virtual_network_enabled"></a> [managed\_virtual\_network\_enabled](#input\_managed\_virtual\_network\_enabled) | Specifies whether or not Managed Virtual Network is enabled for the Synapse Workspace. | `bool` | `false` | no |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | The object id of the Azure AD Administrator of this Synapse Workspace. | `string` | `null` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A private\_endpoints block supports the following:<br>&bull; `name` = string - The name of the Private Endpoint<br>&bull; `private_service_connection_name` = string - The name of the Private Service Connection.<br>&bull; `subnet_id` = string - The Subnet ID where this Network Interface should be located in.<br>&bull; `subresource_names` = string - A list of subresource names which the Private Endpoint is able to connect to. subresource\_names corresponds to group\_id.<br>&bull; `private_dns_zone_name` = string - Private DNS Zone Name<br>&bull; `private_dns_zone_resource_group_name` = string - Private DNS Zone Resource Group Name<br>&bull; `is_manual_connection` = bool - Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner. | <pre>list(object({<br>    name                                 = string<br>    private_service_connection_name      = string<br>    subnet_id                            = string<br>    subresource_names                    = list(string)<br>    private_dns_zone_name                = string<br>    private_dns_zone_resource_group_name = string<br>    is_manual_connection                 = bool<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Specifies whether or not public network access is allowed for the Synapse Workspace. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Synapse workspace. | `string` | n/a | yes |
| <a name="input_sql_administrator_login"></a> [sql\_administrator\_login](#input\_sql\_administrator\_login) | The administrator login name for the new server. | `string` | `"sqladminuser"` | no |
| <a name="input_sql_administrator_login_password"></a> [sql\_administrator\_login\_password](#input\_sql\_administrator\_login\_password) | The password associated with the administrator\_login user. Needs to comply with Azure's Password Policy. | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The id of the storage account associated with Synapse workspace. | `string` | n/a | yes |
| <a name="input_storage_data_lake_name"></a> [storage\_data\_lake\_name](#input\_storage\_data\_lake\_name) | The name of the data lake filesystem associated with Synapse workspace | `string` | n/a | yes |
| <a name="input_synapse_workspace_name"></a> [synapse\_workspace\_name](#input\_synapse\_workspace\_name) | Specifies the name of the Synapse workspace. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant id of the Azure AD Administrator of this Synapse Workspace. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_synapse_workspace_id"></a> [synapse\_workspace\_id](#output\_synapse\_workspace\_id) | n/a |

## Example
<!-- END_TF_DOCS -->