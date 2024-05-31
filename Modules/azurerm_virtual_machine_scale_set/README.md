<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Virtual Machine Scale Set.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.1, < 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.admin_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_windows_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user_name"></a> [admin\_user\_name](#input\_admin\_user\_name) | admin user names for vms | `string` | n/a | yes |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot\_diagnostics\_storage\_account\_uri](#input\_boot\_diagnostics\_storage\_account\_uri) | Boot Diagnostic Storage Account URI. Passing a 'null' value will utilize a Managed Storage Account to store Boot Diagnostics. | `string` | `null` | no |
| <a name="input_computer_name_prefix"></a> [computer\_name\_prefix](#input\_computer\_name\_prefix) | computer name prefix. max of 9 characters | `string` | n/a | yes |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | setting enable password authentication or not on vms | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | The type of Managed Identity which should be assigned to the Virtual Machine Scale Set. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned. identity\_ids is required when type is set to UserAssigned | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | <pre>{<br>  "identity_ids": null,<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | ID of the Key Vault to store the VMSS Credentials in. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | location to deploy too | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The type of VMSS to be created, valid values are `linux` or `windows`. | `string` | n/a | yes |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | Should Azure over-provision Virtual Machines in this Scale Set? Defaults to false. | `bool` | `false` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | Specifies the Platform Fault Domain in which this Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Virtual Machine to be created. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | name of the rescource group to deploy too | `string` | n/a | yes |
| <a name="input_single_placement_group"></a> [single\_placement\_group](#input\_single\_placement\_group) | Should this Virtual Machine Scale Set be limited to a Single Placement Group, which means the number of instances will be capped at 100 Virtual Machines. Defaults to true | `bool` | `false` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | n/a | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet that the VMSS will be deployed too | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | Specifies how Upgrades should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual | `string` | `"Manual"` | no |
| <a name="input_vmss_image_reference"></a> [vmss\_image\_reference](#input\_vmss\_image\_reference) | n/a | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_vmss_instance_count"></a> [vmss\_instance\_count](#input\_vmss\_instance\_count) | number of vm instances to be deployed to the scale set | `number` | `0` | no |
| <a name="input_vmss_name"></a> [vmss\_name](#input\_vmss\_name) | Name of the scale set | `string` | n/a | yes |
| <a name="input_vmss_network_interface"></a> [vmss\_network\_interface](#input\_vmss\_network\_interface) | n/a | <pre>object({<br>    name    = string<br>    primary = bool<br>    ip_configuration = object({<br>      name    = string<br>      primary = bool<br>    })<br>  })</pre> | <pre>{<br>  "ip_configuration": {<br>    "name": "Primary",<br>    "primary": true<br>  },<br>  "name": "Primary",<br>  "primary": true<br>}</pre> | no |
| <a name="input_vmss_os_disk"></a> [vmss\_os\_disk](#input\_vmss\_os\_disk) | n/a | <pre>object({<br>    storage_account_type = string<br>    caching              = string<br>  })</pre> | <pre>{<br>  "caching": "ReadWrite",<br>  "storage_account_type": "StandardSSD_LRS"<br>}</pre> | no |
| <a name="input_vmss_sku"></a> [vmss\_sku](#input\_vmss\_sku) | sku size of vms in the scale set | `string` | n/a | yes |
| <a name="input_zone_balance"></a> [zone\_balance](#input\_zone\_balance) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in. Changing this forces a new resource to be created. | `list(string)` | `null` | no |

## Outputs

No outputs.

## Example
<!-- END_TF_DOCS -->