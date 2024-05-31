<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of an API Management Service with an option to configure a Logger within an API Management Service.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#module\_monitor\_diagnostic\_settings) | ../azurerm_monitor_diagnostic_setting | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.api_management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_backend.api_management_backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_api_management_logger.api_management_logger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_api_management_named_value.api_management_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_public_ip.api_management_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_location"></a> [additional\_location](#input\_additional\_location) | One or more additional\_location block as defined in the following schema:<br><br>**NOTE**: `virtual_network_configuration` is required when `virtual_network_type` is `External` or `Internal`. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br>Availability zones and custom public IPs are only supported in the Premium tier.<br><br>Schema and property description is the following:<pre>[<br>  {<br>    location                      = string        - (Required) - The name of the Azure Region in which the API Management Service should be expanded to.<br>    capacity                      = number        - (Optional) - The number of compute units in this region. Defaults to the capacity of the main region.<br>    zones                         = list(string)  - (Optional) - A list of availability zones.<br>    public_ip_address_id          = string        - (Optional) - ID of a standard SKU IPv4 Public IP.<br>    gateway_disabled              = bool          - (Optional) - Only valid for an Api Management service deployed in multiple locations. This can be used to disable the gateway in this additional location.<br>        <br>    virtual_network_configuration = object        - (Optional)<br>      { <br>        subnet_id                 = string        - (Required) - The ID of the subnet that will be used for the API Management.<br>      }<br>  }<br>]</pre> | <pre>list(object({<br>    location             = string<br>    capacity             = optional(number, null)<br>    zones                = optional(list(string), [])<br>    public_ip_address_id = optional(string, null)<br>    gateway_disabled     = optional(bool, null)<br><br>    virtual_network_configuration = optional(object({<br>      subnet_id = string<br>    }), null)<br>  }))</pre> | `[]` | no |
| <a name="input_apim_logger_details"></a> [apim\_logger\_details](#input\_apim\_logger\_details) | A apim\_logger\_details block as defined in the following schema:<br><br>**NOTE**: `apim_logger_details` is required to configure Logger within an API Management Service. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  name                    = string  - (Required) The name of this Logger, which must be unique within the API Management Service.<br>  buffered                = bool    - (Optional) Specifies whether records should be buffered in the Logger prior to publishing. Defaults to `true`.<br>  description             = string  - (Optional) A description of this Logger.<br>  resource_id             = string  - (Optional) The target resource id which will be linked in the API-Management portal page.<br><br>  application_insights    = object  - (Optional)<br>    {<br>      instrumentation_key = string  - (Required) The instrumentation key used to push data to Application Insights.<br>    }<br><br>  eventhub                = object  - (Optional)<br>    {<br>      name                = string  - (Required) The name of an EventHub.<br>      connection_string   = string  - (Required) The connection string of an EventHub Namespace.<br>    }<br>}</pre> | <pre>object({<br>    name        = string<br>    buffered    = optional(bool, true)<br>    description = optional(string, null)<br>    resource_id = optional(string, null)<br><br>    application_insights = optional(object({<br>      instrumentation_key = string<br>    }), null)<br><br>    eventhub = optional(object({<br>      name              = string<br>      connection_string = string<br>    }), null)<br>  })</pre> | `null` | no |
| <a name="input_backends"></a> [backends](#input\_backends) | n/a | <pre>list(object({<br>    name        = string<br>    protocol    = string<br>    url         = string<br>    resource_id = string<br>    description = string<br>    tls = object({<br>      validate_certificate_chain = bool<br>      validate_certificate_name  = bool<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | One or more (up to 10) certificate blocks as defined in the following schema:<br><br> **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br> Schema and property description is the following:<pre>[<br>    {<br>      encoded_certificate  = string - (Required) - The Base64 Encoded PFX or Base64 Encoded X.509 Certificate.<br>      store_name           = string - (Required) - The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.<br>      certificate_password = string - (Optional) - The password for the certificate.<br>    }<br>  ]</pre> | <pre>list(object({<br>    encoded_certificate  = string<br>    store_name           = string<br>    certificate_password = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption. | `bool` | `null` | no |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | A delegation block as defined in the following schema:<pre>{<br>  subscriptions_enabled       = bool   - (Optional) - Should subscription requests be delegated to an external url?<br>  user_registration_enabled   = bool   - (Optional) - Should user registration requests be delegated to an external url?<br>  url                         = string - (Optional) - The delegation URL.<br>  validation_key              = string - (Optional) - A base64-encoded validation key to validate that a request is coming from Azure API Management.<br>}</pre> | <pre>object({<br>    subscriptions_enabled     = optional(bool, false)<br>    user_registration_enabled = optional(bool, false)<br>    url                       = optional(string, null)<br>    validation_key            = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable Diagnostic Settings. | `bool` | `false` | no |
| <a name="input_gateway_disabled"></a> [gateway\_disabled](#input\_gateway\_disabled) | Disable the gateway in the main region? This is only supported when additional\_location is set. | `bool` | `null` | no |
| <a name="input_hostname_configuration"></a> [hostname\_configuration](#input\_hostname\_configuration) | A hostname\_configuration block as defined in the following schema:<pre>{<br>  management                          = list(object) - (Optional) - One or more management blocks with the following properties:<br>    {<br>      host_name                       = string       - (Required) - The Hostname to use for the Management API.<br>      key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.<br>      certificate                     = string       - (Optional) - The Base64 Encoded Certificate.<br>      certificate_password            = string       - (Optional) - The password associated with the certificate provided above.<br>      negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?<br>      ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.<br>    }<br><br>  portal                              = list(object) - (Optional) - One or more portal blocks with the following properties:<br>    {<br>      host_name                       = string       - (Required) - The Hostname to use for the Management API.<br>      key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.<br>      certificate                     = string       - (Optional) - The Base64 Encoded Certificate.<br>      certificate_password            = string       - (Optional) - The password associated with the certificate provided above.<br>      negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?<br>      ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.<br>    }<br><br>  developer_portal                    = list(object) - (Optional) - One or more portal blocks with the following properties:<br>    {<br>      host_name                       = string       - (Required) - The Hostname to use for the Management API.<br>      key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.<br>      certificate                     = string       - (Optional) - The Base64 Encoded Certificate.<br>      certificate_password            = string       - (Optional) - The password associated with the certificate provided above.<br>      negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?<br>      ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.<br>    }<br><br>  proxy                               = list(object) - (Optional) - One or more ptoxy blocks with the following properties:<br>    {<br>      default_ssl_binding             = bool         - (Optional) - Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client.<br>      host_name                       = string       - (Required) - The Hostname to use for the Management API.<br>      key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.<br>      certificate                     = string       - (Optional) - The Base64 Encoded Certificate.<br>      certificate_password            = string       - (Optional) - The password associated with the certificate provided above.<br>      negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?<br>      ssl_keyvault_identity_client_id = string       - (Optional) - The Managed Identity Client ID to use to access the Key Vault. This Identity must be specified in the identity block to be used.<br>    }<br><br>  scm                                 = list(object) - (Optional) - One or more scm blocks with the following properties:<br>    {<br>      host_name                       = string       - (Required) - The Hostname to use for the Management API.<br>      key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.<br>      certificate                     = string       - (Optional) - The Base64 Encoded Certificate.<br>      certificate_password            = string       - (Optional) - The password associated with the certificate provided above.<br>      negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?<br>      ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD.<br>    }<br>}</pre> | <pre>object({<br>    management = optional(list(object({<br>      host_name                       = string<br>      key_vault_id                    = optional(string, null)<br>      certificate                     = optional(string, null)<br>      certificate_password            = optional(string, null)<br>      negotiate_client_certificate    = optional(bool, false)<br>      ssl_keyvault_identity_client_id = optional(string, null)<br>    })), null)<br><br>    portal = optional(list(object({<br>      host_name                       = string<br>      key_vault_id                    = optional(string, null)<br>      certificate                     = optional(string, null)<br>      certificate_password            = optional(string, null)<br>      negotiate_client_certificate    = optional(bool, false)<br>      ssl_keyvault_identity_client_id = optional(string, null)<br>    })), null)<br><br>    developer_portal = optional(list(object({<br>      host_name                       = string<br>      key_vault_id                    = optional(string, null)<br>      certificate                     = optional(string, null)<br>      certificate_password            = optional(string, null)<br>      negotiate_client_certificate    = optional(bool, false)<br>      ssl_keyvault_identity_client_id = optional(string, null)<br>    })), null)<br><br>    proxy = optional(list(object({<br>      default_ssl_binding             = optional(bool, false)<br>      host_name                       = string<br>      key_vault_id                    = optional(string, null)<br>      certificate                     = optional(string, null)<br>      certificate_password            = optional(string, null)<br>      negotiate_client_certificate    = optional(bool, false)<br>      ssl_keyvault_identity_client_id = optional(string, null)<br>    })), null)<br><br>    scm = optional(list(object({<br>      host_name                       = string<br>      key_vault_id                    = optional(string, null)<br>      certificate                     = optional(string, null)<br>      certificate_password            = optional(string, null)<br>      negotiate_client_certificate    = optional(bool, false)<br>      ssl_keyvault_identity_client_id = optional(string, null)<br>    })), null)<br>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Identities IDs to add to logic App. Mandatory if type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Add an Identity (MSI) to the logic app. Possible values are SystemAssigned or UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the API Management Service exists. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send Diagnostic to. | `string` | `null` | no |
| <a name="input_min_api_version"></a> [min\_api\_version](#input\_min\_api\_version) | The version which the control plane API calls to API Management service are limited with version equal to or newer than. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the API Management Service. | `string` | n/a | yes |
| <a name="input_named_values"></a> [named\_values](#input\_named\_values) | n/a | <pre>list(object({<br>    name         = string<br>    display_name = string<br>    value        = string<br>    value_from_key_vault = list(object({<br>      secret_id          = string<br>      identity_client_id = string<br>    }))<br>    secret = string<br>    tags   = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_notification_sender_email"></a> [notification\_sender\_email](#input\_notification\_sender\_email) | Email address from which the notification will be sent. | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A policy block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  xml_content = string - (Optional) - The XML Content for this Policy.<br>  xml_link    = string - (Optional) - A link to an API Management Policy XML Document, which must be publicly available.<br>}</pre> | <pre>object({<br>    xml_content = optional(string, null)<br>    xml_link    = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | A protocols block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  enable_http2 = bool - (Optional) - Should HTTP/2 be supported by the API Management Service?<br>}</pre> | <pre>object({<br>    enable_http2 = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_public_ip_allocation_method"></a> [public\_ip\_allocation\_method](#input\_public\_ip\_allocation\_method) | The allocation method for the Public IP Address. | `string` | `"Static"` | no |
| <a name="input_public_ip_domain_name_label"></a> [public\_ip\_domain\_name\_label](#input\_public\_ip\_domain\_name\_label) | The Domain Name Label for the Public IP Address. | `string` | `null` | no |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | The name of the Public IP Address. | `string` | n/a | yes |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The SKU of the Public IP Address. Valid values are `Basic` and `Standard`. Default is `Standard`. | `string` | `"Standard"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Is public access to the service allowed? | `bool` | `true` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email of the publisher/company. | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of publisher/company. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group in which the API Management Service should exist. | `string` | n/a | yes |
| <a name="input_security"></a> [security](#input\_security) | A security block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  enable_backend_ssl30                                 = bool - (Optional) - Should SSL 3.0 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30` field.<br>  enable_backend_tls10                                 = bool - (Optional) - Should TLS 1.0 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10` field.<br>  enable_backend_tls11                                 = bool - (Optional) - Should TLS 1.1 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11` field.<br>  enable_frontend_ssl30                                = bool - (Optional) - Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30` field.<br>  enable_frontend_tls10                                = bool - (Optional) - Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10` field.<br>  enable_frontend_tls11                                = bool - (Optional) - Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11` field.<br>  tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled  = bool - (Optional) - Should the TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA` field.<br>  tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled  = bool - (Optional) - Should the TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA` field.<br>  tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled    = bool - (Optional) - Should the TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA` field.<br>  tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled    = bool - (Optional) - Should the TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA` field.<br>  tls_rsa_with_aes128_cbc_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA256` field.<br>  tls_rsa_with_aes128_cbc_sha_ciphers_enabled          = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA` field.<br>  tls_rsa_with_aes128_gcm_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_GCM_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_GCM_SHA256` field.<br>  tls_rsa_with_aes256_gcm_sha384_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_GCM_SHA384 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_GCM_SHA384` field.<br>  tls_rsa_with_aes256_cbc_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA256` field.<br>  tls_rsa_with_aes256_cbc_sha_ciphers_enabled          = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA` field.<br>  triple_des_ciphers_enabled                           = bool - (Optional) - Should the TLS_RSA_WITH_3DES_EDE_CBC_SHA cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168` field.<br>}</pre> | <pre>object({<br>    enable_backend_ssl30                                = optional(bool, false)<br>    enable_backend_tls10                                = optional(bool, false)<br>    enable_backend_tls11                                = optional(bool, false)<br>    enable_frontend_ssl30                               = optional(bool, false)<br>    enable_frontend_tls10                               = optional(bool, false)<br>    enable_frontend_tls11                               = optional(bool, false)<br>    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)<br>    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)<br>    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)<br>    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)<br>    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)<br>    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)<br>    triple_des_ciphers_enabled                          = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_sign_in"></a> [sign\_in](#input\_sign\_in) | A sign\_in block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  enabled = bool - (Required) - Should anonymous users be redirected to the sign in page?<br>}</pre> | <pre>object({<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_sign_up"></a> [sign\_up](#input\_sign\_up) | A sign\_up block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  enabled              = bool   - (Required) - Can users sign up on the development portal?<br><br>  terms_of_service     = object - (Required)<br>    {<br>      consent_required = bool   - (Required) - Should the user be asked for consent during sign up?<br>      enabled          = bool   - (Required) - Should Terms of Service be displayed during sign up?<br>      text             = string - (Optional) - The Terms of Service which users are required to agree to in order to sign up.<br>    }<br>}</pre> | <pre>object({<br>    enabled = bool<br><br>    terms_of_service = object({<br>      consent_required = bool<br>      enabled          = bool<br>      text             = optional(string, null)<br>    })<br>  })</pre> | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name is a string consisting of two parts separated by an underscore(\_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard, and Premium. The second part is the capacity (e.g. the number of deployed units of the SKU), which must be a positive integer (e.g. Developer\_1). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_tenant_access"></a> [tenant\_access](#input\_tenant\_access) | A tenant\_access block as defined in the following schema:<br><br>**NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  enabled = bool - (Required) - Should the access to the management API be enabled?<br>}</pre> | <pre>object({<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_virtual_network_configuration"></a> [virtual\_network\_configuration](#input\_virtual\_network\_configuration) | A virtual\_network\_configuration block as defined in the following schema:<br><br>**NOTE**: `virtual_network_configuration` is required when virtual\_network\_type is External or Internal. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br><br>Schema and property description is the following:<pre>{<br>  subnet_id = string - (Required) - The id of the subnet that will be used for the API Management.<br>}</pre> | <pre>object({<br>    subnet_id = string<br>  })</pre> | `null` | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The type of virtual network you want to use, valid values include: `None`, `External`, `Internal`.<br><br>**NOTE**: Please ensure that in the subnet, inbound port `3443` is open when virtual\_network\_type is `Internal` or `External`.<br>And please ensure other necessary ports are open according to [this](https://docs.microsoft.com/en-us/azure/api-management/api-management-using-with-vnet#-common-network-configuration-issues). | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies a list of Availability Zones in which this API Management service should be located. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_location"></a> [additional\_location](#output\_additional\_location) | Zero or more additional\_location blocks as defined below;<pre>{<br>    gateway_regional_url    - The URL of the Regional Gateway for the API Management Service in the specified region.<br>    public_ip_addresses     - Public Static Load Balanced IP addresses of the API Management service in the additional location. Available only for Basic, Standard and Premium SKU.<br>    private_ip_addresses    - The Private IP addresses of the API Management Service. Available only when the API Manager instance is using Virtual Network mode.<br>}</pre> |
| <a name="output_api_management"></a> [api\_management](#output\_api\_management) | Outputs the full attributes of the API Management Service. |
| <a name="output_api_management_logger_id"></a> [api\_management\_logger\_id](#output\_api\_management\_logger\_id) | The id of the API Management Logger. |
| <a name="output_api_management_logger_name"></a> [api\_management\_logger\_name](#output\_api\_management\_logger\_name) | The Name of the API Management Logger. |
| <a name="output_developer_portal_url"></a> [developer\_portal\_url](#output\_developer\_portal\_url) | The URL for the Developer Portal associated with this API Management service. |
| <a name="output_gateway_regional_url"></a> [gateway\_regional\_url](#output\_gateway\_regional\_url) | The Region URL for the Gateway of the API Management Service. |
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The URL of the Gateway for the API Management Service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the API Management Service. |
| <a name="output_identity"></a> [identity](#output\_identity) | An identity block as defined below, which contains the Managed Service Identity information for this App Service.<pre>{<br>    principal_id - The Principal ID for the Service Principal associated with the Managed Service Identity of this App Service.<br>    tenant_id    - The Tenant ID for the Service Principal associated with the Managed Service Identity of this App Service.<br>}</pre> |
| <a name="output_management_api_url"></a> [management\_api\_url](#output\_management\_api\_url) | The URL for the Management API associated with this API Management service. |
| <a name="output_name"></a> [name](#output\_name) | The name of the API Management Service. |
| <a name="output_portal_url"></a> [portal\_url](#output\_portal\_url) | The URL for the Publisher Portal associated with this API Management service. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The Private IP addresses of the API Management Service. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | The Public IP addresses of the API Management Service. |
| <a name="output_scm_url"></a> [scm\_url](#output\_scm\_url) | The URL for the SCM (Source Code Management) Endpoint associated with this API Management service. |
| <a name="output_tenant_access"></a> [tenant\_access](#output\_tenant\_access) | The tenant\_access block as defined below;<pre>{<br>    tenant_id       - The identifier for the tenant access information contract.<br>    primary_key     - Primary access key for the tenant access information contract.<br>    secondary_key   - Secondary access key for the tenant access information contract.<br>}</pre> |

## Example
<!-- END_TF_DOCS -->