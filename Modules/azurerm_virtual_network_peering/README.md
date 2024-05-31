<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Virtual Network Peering.

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
| [azurerm_virtual_network_peering.hub_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub_allow_forwarded_traffic"></a> [hub\_allow\_forwarded\_traffic](#input\_hub\_allow\_forwarded\_traffic) | n/a | `string` | n/a | yes |
| <a name="input_hub_allow_gateway_transit"></a> [hub\_allow\_gateway\_transit](#input\_hub\_allow\_gateway\_transit) | n/a | `string` | n/a | yes |
| <a name="input_hub_allow_virtual_network_access"></a> [hub\_allow\_virtual\_network\_access](#input\_hub\_allow\_virtual\_network\_access) | n/a | `string` | n/a | yes |
| <a name="input_hub_subscription_id"></a> [hub\_subscription\_id](#input\_hub\_subscription\_id) | hub subscription ID | `string` | n/a | yes |
| <a name="input_hub_use_remote_gateways"></a> [hub\_use\_remote\_gateways](#input\_hub\_use\_remote\_gateways) | n/a | `string` | n/a | yes |
| <a name="input_hub_virtual_network_name"></a> [hub\_virtual\_network\_name](#input\_hub\_virtual\_network\_name) | hub virtual network name | `string` | n/a | yes |
| <a name="input_hub_virtual_network_resource_group_name"></a> [hub\_virtual\_network\_resource\_group\_name](#input\_hub\_virtual\_network\_resource\_group\_name) | hub virtual network resource group name | `string` | n/a | yes |
| <a name="input_spoke_allow_forwarded_traffic"></a> [spoke\_allow\_forwarded\_traffic](#input\_spoke\_allow\_forwarded\_traffic) | n/a | `string` | n/a | yes |
| <a name="input_spoke_allow_gateway_transit"></a> [spoke\_allow\_gateway\_transit](#input\_spoke\_allow\_gateway\_transit) | n/a | `string` | n/a | yes |
| <a name="input_spoke_allow_virtual_network_access"></a> [spoke\_allow\_virtual\_network\_access](#input\_spoke\_allow\_virtual\_network\_access) | n/a | `string` | n/a | yes |
| <a name="input_spoke_subscription_id"></a> [spoke\_subscription\_id](#input\_spoke\_subscription\_id) | spoke subscription ID | `string` | n/a | yes |
| <a name="input_spoke_use_remote_gateways"></a> [spoke\_use\_remote\_gateways](#input\_spoke\_use\_remote\_gateways) | n/a | `string` | n/a | yes |
| <a name="input_spoke_virtual_network_name"></a> [spoke\_virtual\_network\_name](#input\_spoke\_virtual\_network\_name) | spoke virtual network name | `string` | n/a | yes |
| <a name="input_spoke_virtual_network_resource_group_name"></a> [spoke\_virtual\_network\_resource\_group\_name](#input\_spoke\_virtual\_network\_resource\_group\_name) | spoke virtual network resource group name | `string` | n/a | yes |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->