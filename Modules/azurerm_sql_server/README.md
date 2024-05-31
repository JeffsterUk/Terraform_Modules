<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a SQL Server.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#module\_monitor\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |
| <a name="module_monitor_diagnostic_settings_db"></a> [monitor\_diagnostic\_settings\_db](#module\_monitor\_diagnostic\_settings\_db) | ../azurerm_monitor_diagnostic_setting | n/a |
| <a name="module_private_endpoints"></a> [private\_endpoints](#module\_private\_endpoints) | ../azurerm_private_endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_mssql_outbound_firewall_rule.outbound_fw_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_outbound_firewall_rule) | resource |
| [azurerm_mssql_server.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.auditing_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the new server. | `string` | n/a | yes |
| <a name="input_azuread_administrator"></a> [azuread\_administrator](#input\_azuread\_administrator) | An object representing an Azure AD Administrator. <br><br>An Azure AD Administrator object adheres to the following schema:<pre>azuread_administrator = {<br><br>  login_username              = string - (Required) The login username of the Azure AD Administrator of this SQL Server.<br>  object_id                   = string - (Required) The object id of the Azure AD Administrator of this SQL Server.<br>  tenant_id                   = string - (Optional) The tenant id of the Azure AD Administrator of this SQL Server.<br>  azuread_authentication_only = string - (Optional) Specifies whether only AD Users and administrators (like `azuread_administrator.0.login_username`) can be used to login or also local database users (like `administrator_login`).<br><br>}<br><br>**NOTE**: An optional property that is not required must be explicitly set to `null`</pre> | <pre>object({<br>    login_username              = string<br>    object_id                   = string<br>    tenant_id                   = string<br>    azuread_authentication_only = string<br>  })</pre> | `null` | no |
| <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy) | The connection policy the server will use. Possible values are `Default`, `Proxy`, and `Redirect`. Defaults to `Default`. | `string` | `null` | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable Diagnostic Settings. | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | keyvault sub id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send Diagnostic to. | `string` | `null` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: `1.0`, `1.1` and `1.2`. | `string` | `"1.2"` | no |
| <a name="input_outbound_network_restriction_enabled"></a> [outbound\_network\_restriction\_enabled](#input\_outbound\_network\_restriction\_enabled) | Whether outbound network traffic is restricted for this server | `bool` | `false` | no |
| <a name="input_primary_user_assigned_identity_id"></a> [primary\_user\_assigned\_identity\_id](#input\_primary\_user\_assigned\_identity\_id) | identity type is user then this needed | `string` | `null` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | private endpoint values of service bus | `list(any)` | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Microsoft SQL Server. | `string` | n/a | yes |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | The name of the Microsoft SQL Server. This needs to be globally unique within Azure. | `string` | n/a | yes |
| <a name="input_sql_version"></a> [sql\_version](#input\_sql\_version) | The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). | `string` | `"12.0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fully_qualified_domain_name"></a> [fully\_qualified\_domain\_name](#output\_fully\_qualified\_domain\_name) | The fully qualified domain name of the Azure SQL Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure SQL Server. |
| <a name="output_identity"></a> [identity](#output\_identity) | An identity block containing the Principal ID and Tenant ID for the Service Principal assocated with the Identity of this SQL Server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure SQL Server. |

## Example
<!-- END_TF_DOCS -->