<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Private Endpoint.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostic_settings"></a> [diagnostic\_settings](#module\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | The diagnostic settings block supports the following arguments:<br><br>- name                       = String - The name of the diagnostic settings.<br>- log\_analytics\_workspace\_id = String - The ID of the Log Analytics Workspace to send diagnostic logs to. | <pre>object({<br>    name                       = string<br>    log_analytics_workspace_id = string<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the Private Endpoint resources will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Private Endpoint. | `string` | n/a | yes |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | The private dns zone group block supports the following arguments:<br><br>- name                 = String - The name of the private dns zone group.<br>- private\_dns\_zone\_ids = List   - A list of private dns zone IDs. | <pre>object({<br>    name                 = string<br>    private_dns_zone_ids = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | The private service connection block supports the following arguments:<br><br>- name                           = String  - The name of the private service connection.<br>- private\_connection\_resource\_id = String  - The ID of the resource to connect to.<br>- is\_manual\_connection           = Boolean - Whether the connection is manual or automatic. Defaults to false.<br>- subresource\_names              = List    - A list of subresources to connect to. | <pre>object({<br>    name                           = string<br>    private_connection_resource_id = string<br>    is_manual_connection           = optional(string, false)<br>    subresource_names              = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Private Endpoint will be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where the Private Endpoint will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the Private Endpoint. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_dns_configs"></a> [custom\_dns\_configs](#output\_custom\_dns\_configs) | The FQDN and a list of all the IP Addresses that map to the Private Endpoint FQDN. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Endpoint. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Private Endpoint. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Private IP Address of the Private Endpoint. |

## Example
<!-- END_TF_DOCS -->