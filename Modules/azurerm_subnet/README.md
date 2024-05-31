<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Subnet.

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
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | The address prefixes to use for the Subnet. | `list(string)` | n/a | yes |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | Service delegation details for the subnet. | <pre>list(object({<br>    servicename = string<br>    actions     = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Subnet. | `string` | n/a | yes |
| <a name="input_nsg_details"></a> [nsg\_details](#input\_nsg\_details) | Attribute nsg\_id is required if NSG-Subnet association is required. | <pre>object({<br>    is_nsg_subnet_association_required = bool<br>    nsg_id                             = string<br>  })</pre> | <pre>{<br>  "is_nsg_subnet_association_required": false,<br>  "nsg_id": null<br>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group in which to create the subnet. | `string` | n/a | yes |
| <a name="input_route_table_details"></a> [route\_table\_details](#input\_route\_table\_details) | Attribute route\_table\_id is required if RouteTable-Subnet association is required. | <pre>object({<br>    is_route_table_subnet_association_required = bool<br>    route_table_id                             = string<br>  })</pre> | <pre>{<br>  "is_route_table_subnet_association_required": false,<br>  "route_table_id": null<br>}</pre> | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of Service Endpoints to associate with the Subnet. Possible values include Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry etc. | `list(string)` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the Virtual Network to attach the subnet to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the Subnet. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of the Subnet. |

## Example
<!-- END_TF_DOCS -->