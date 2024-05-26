variable "name" {
  type        = string
  description = "The name of the API Management Service."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the API Management Service should exist."
}

variable "location" {
  type        = string
  description = "The Azure location where the API Management Service exists."
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
}

variable "publisher_email" {
  type        = string
  description = "The email of the publisher/company."
}

variable "sku_name" {
  type        = string
  description = "The SKU name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard, and Premium. The second part is the capacity (e.g. the number of deployed units of the SKU), which must be a positive integer (e.g. Developer_1)."
}

variable "client_certificate_enabled" {
  type        = bool
  description = "Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption."
  default     = null
}

variable "gateway_disabled" {
  type        = bool
  description = "Disable the gateway in the main region? This is only supported when additional_location is set."
  default     = null
}

variable "min_api_version" {
  type        = string
  description = "The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  default     = null
}

variable "zones" {
  type        = list(string)
  description = "Specifies a list of Availability Zones in which this API Management service should be located."
  default     = []
}

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Is public access to the service allowed?"
  default     = true
}

variable "public_ip_allocation_method" {
  type        = string
  description = "The allocation method for the Public IP Address."
  default     = "Static"
}

variable "public_ip_name" {
  type        = string
  description = "The name of the Public IP Address."
}

variable "public_ip_sku" {
  type        = string
  description = "The SKU of the Public IP Address. Valid values are `Basic` and `Standard`. Default is `Standard`."
  default     = "Standard"
}

variable "public_ip_domain_name_label" {
  type        = string
  description = "The Domain Name Label for the Public IP Address."
  default     = null
}

variable "virtual_network_type" {
  type        = string
  description = <<-EOT
    The type of virtual network you want to use, valid values include: `None`, `External`, `Internal`.

    **NOTE**: Please ensure that in the subnet, inbound port `3443` is open when virtual_network_type is `Internal` or `External`.
    And please ensure other necessary ports are open according to [this](https://docs.microsoft.com/en-us/azure/api-management/api-management-using-with-vnet#-common-network-configuration-issues).

    EOT

  default = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "additional_location" {
  type = list(object({
    location             = string
    capacity             = optional(number, null)
    zones                = optional(list(string), [])
    public_ip_address_id = optional(string, null)
    gateway_disabled     = optional(bool, null)

    virtual_network_configuration = optional(object({
      subnet_id = string
    }), null)
  }))

  description = <<-EOT
    One or more additional_location block as defined in the following schema:

    **NOTE**: `virtual_network_configuration` is required when `virtual_network_type` is `External` or `Internal`. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).
    Availability zones and custom public IPs are only supported in the Premium tier.
    
    Schema and property description is the following:
    ```
    [
      {
        location                      = string        - (Required) - The name of the Azure Region in which the API Management Service should be expanded to.
        capacity                      = number        - (Optional) - The number of compute units in this region. Defaults to the capacity of the main region.
        zones                         = list(string)  - (Optional) - A list of availability zones.
        public_ip_address_id          = string        - (Optional) - ID of a standard SKU IPv4 Public IP.
        gateway_disabled              = bool          - (Optional) - Only valid for an Api Management service deployed in multiple locations. This can be used to disable the gateway in this additional location.
        
        virtual_network_configuration = object        - (Optional)
          { 
            subnet_id                 = string        - (Required) - The ID of the subnet that will be used for the API Management.
          }
      }
    ]
    ```
    EOT

  default = []
}

variable "certificate" {
  type = list(object({
    encoded_certificate  = string
    store_name           = string
    certificate_password = optional(string, null)
  }))

  description = <<-EOT
    One or more (up to 10) certificate blocks as defined in the following schema:

     **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).
     Schema and property description is the following:
      ```
      [
        {
          encoded_certificate  = string - (Required) - The Base64 Encoded PFX or Base64 Encoded X.509 Certificate.
          store_name           = string - (Required) - The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.
          certificate_password = string - (Optional) - The password for the certificate.
        }
      ] 
      ```
    EOT

  default = null
}

variable "delegation" {
  type = object({
    subscriptions_enabled     = optional(bool, false)
    user_registration_enabled = optional(bool, false)
    url                       = optional(string, null)
    validation_key            = optional(string, null)
  })

  description = <<-EOT
    A delegation block as defined in the following schema:
    ```
    {
      subscriptions_enabled       = bool   - (Optional) - Should subscription requests be delegated to an external url?
      user_registration_enabled   = bool   - (Optional) - Should user registration requests be delegated to an external url?
      url                         = string - (Optional) - The delegation URL.
      validation_key              = string - (Optional) - A base64-encoded validation key to validate that a request is coming from Azure API Management.
    } 
    ```
  EOT

  default = null
}

variable "hostname_configuration" {
  type = object({
    management = optional(list(object({
      host_name                       = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), null)

    portal = optional(list(object({
      host_name                       = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), null)

    developer_portal = optional(list(object({
      host_name                       = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), null)

    proxy = optional(list(object({
      default_ssl_binding             = optional(bool, false)
      host_name                       = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), null)

    scm = optional(list(object({
      host_name                       = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), null)
  })

  description = <<-EOT
    A hostname_configuration block as defined in the following schema:
    ```
    {
      management                          = list(object) - (Optional) - One or more management blocks with the following properties:
        {
          host_name                       = string       - (Required) - The Hostname to use for the Management API.
          key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.
          certificate                     = string       - (Optional) - The Base64 Encoded Certificate.
          certificate_password            = string       - (Optional) - The password associated with the certificate provided above.
          negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?
          ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.
        }

      portal                              = list(object) - (Optional) - One or more portal blocks with the following properties:
        {
          host_name                       = string       - (Required) - The Hostname to use for the Management API.
          key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.
          certificate                     = string       - (Optional) - The Base64 Encoded Certificate.
          certificate_password            = string       - (Optional) - The password associated with the certificate provided above.
          negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?
          ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.
        }

      developer_portal                    = list(object) - (Optional) - One or more portal blocks with the following properties:
        {
          host_name                       = string       - (Required) - The Hostname to use for the Management API.
          key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.
          certificate                     = string       - (Optional) - The Base64 Encoded Certificate.
          certificate_password            = string       - (Optional) - The password associated with the certificate provided above.
          negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?
          ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD, which has GET access to the keyVault containing the SSL certificate.
        }

      proxy                               = list(object) - (Optional) - One or more ptoxy blocks with the following properties:
        {
          default_ssl_binding             = bool         - (Optional) - Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client.
          host_name                       = string       - (Required) - The Hostname to use for the Management API.
          key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
          certificate                     = string       - (Optional) - The Base64 Encoded Certificate.
          certificate_password            = string       - (Optional) - The password associated with the certificate provided above.
          negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?
          ssl_keyvault_identity_client_id = string       - (Optional) - The Managed Identity Client ID to use to access the Key Vault. This Identity must be specified in the identity block to be used.
        }

      scm                                 = list(object) - (Optional) - One or more scm blocks with the following properties:
        {
          host_name                       = string       - (Required) - The Hostname to use for the Management API.
          key_vault_id                    = string       - (Optional) - The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type application/x-pkcs12.
          certificate                     = string       - (Optional) - The Base64 Encoded Certificate.
          certificate_password            = string       - (Optional) - The password associated with the certificate provided above.
          negotiate_client_certificate    = bool         - (Optional) - Should Client Certificate Negotiation be enabled for this Hostname?
          ssl_keyvault_identity_client_id = string       - (Optional) - System or User Assigned Managed identity clientId as generated by Azure AD.
        }
    } 
    ```
  EOT

  default = null
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the logic app. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to logic App. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
}

variable "policy" {
  type = object({
    xml_content = optional(string, null)
    xml_link    = optional(string, null)
  })
  description = <<-EOT
    A policy block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      xml_content = string - (Optional) - The XML Content for this Policy.
      xml_link    = string - (Optional) - A link to an API Management Policy XML Document, which must be publicly available.
    } 
    ```
  EOT

  default = null
}

variable "protocols" {
  type = object({
    enable_http2 = optional(bool, false)
  })

  description = <<-EOT
    A protocols block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      enable_http2 = bool - (Optional) - Should HTTP/2 be supported by the API Management Service?
    } 
    ```
  EOT

  default = null
}

variable "security" {
  type = object({
    enable_backend_ssl30                                = optional(bool, false)
    enable_backend_tls10                                = optional(bool, false)
    enable_backend_tls11                                = optional(bool, false)
    enable_frontend_ssl30                               = optional(bool, false)
    enable_frontend_tls10                               = optional(bool, false)
    enable_frontend_tls11                               = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)
    triple_des_ciphers_enabled                          = optional(bool, false)
  })

  description = <<-EOT
    A security block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      enable_backend_ssl30                                 = bool - (Optional) - Should SSL 3.0 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30` field.
      enable_backend_tls10                                 = bool - (Optional) - Should TLS 1.0 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10` field.
      enable_backend_tls11                                 = bool - (Optional) - Should TLS 1.1 be enabled on the backend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11` field.
      enable_frontend_ssl30                                = bool - (Optional) - Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30` field.
      enable_frontend_tls10                                = bool - (Optional) - Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10` field.
      enable_frontend_tls11                                = bool - (Optional) - Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11` field.
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled  = bool - (Optional) - Should the TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA` field.
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled  = bool - (Optional) - Should the TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA` field.
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled    = bool - (Optional) - Should the TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA` field.
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled    = bool - (Optional) - Should the TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA` field.
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA256` field.
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled          = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA` field.
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_128_GCM_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_GCM_SHA256` field.
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_GCM_SHA384 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_GCM_SHA384` field.
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled       = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA256` field.
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled          = bool - (Optional) - Should the TLS_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA` field.
      triple_des_ciphers_enabled                           = bool - (Optional) - Should the TLS_RSA_WITH_3DES_EDE_CBC_SHA cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? This maps to the `Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168` field.
    }
    ```
  EOT

  default = null
}

variable "sign_in" {
  type = object({
    enabled = bool
  })

  description = <<-EOT
    A sign_in block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      enabled = bool - (Required) - Should anonymous users be redirected to the sign in page?
    }
    ```
  EOT

  default = null
}

variable "sign_up" {
  type = object({
    enabled = bool

    terms_of_service = object({
      consent_required = bool
      enabled          = bool
      text             = optional(string, null)
    })
  })

  description = <<-EOT
    A sign_up block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      enabled              = bool   - (Required) - Can users sign up on the development portal?

      terms_of_service     = object - (Required)
        {
          consent_required = bool   - (Required) - Should the user be asked for consent during sign up?
          enabled          = bool   - (Required) - Should Terms of Service be displayed during sign up?
          text             = string - (Optional) - The Terms of Service which users are required to agree to in order to sign up.
        }
    }
    ```
  EOT

  default = null
}

variable "tenant_access" {
  type = object({
    enabled = bool
  })

  description = <<-EOT
    A tenant_access block as defined in the following schema:

    **NOTE**: If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      enabled = bool - (Required) - Should the access to the management API be enabled?
    }
    ```
  EOT

  default = null
}

variable "virtual_network_configuration" {
  type = object({
    subnet_id = string
  })

  description = <<-EOT
    A virtual_network_configuration block as defined in the following schema:

    **NOTE**: `virtual_network_configuration` is required when virtual_network_type is External or Internal. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      subnet_id = string - (Required) - The id of the subnet that will be used for the API Management.
    }
    ```
  EOT

  default = null
}

variable "apim_logger_details" {
  type = object({
    name        = string
    buffered    = optional(bool, true)
    description = optional(string, null)
    resource_id = optional(string, null)

    application_insights = optional(object({
      instrumentation_key = string
    }), null)

    eventhub = optional(object({
      name              = string
      connection_string = string
    }), null)
  })

  description = <<-EOT
    A apim_logger_details block as defined in the following schema:

    **NOTE**: `apim_logger_details` is required to configure Logger within an API Management Service. If a property below is not needed then it needs to be explicitly set to `null` or `[]` (empty list).

    Schema and property description is the following:
    ```
    {
      name                    = string  - (Required) The name of this Logger, which must be unique within the API Management Service.
      buffered                = bool    - (Optional) Specifies whether records should be buffered in the Logger prior to publishing. Defaults to `true`.
      description             = string  - (Optional) A description of this Logger.
      resource_id             = string  - (Optional) The target resource id which will be linked in the API-Management portal page.

      application_insights    = object  - (Optional)
        {
          instrumentation_key = string  - (Required) The instrumentation key used to push data to Application Insights.
        }

      eventhub                = object  - (Optional)
        {
          name                = string  - (Required) The name of an EventHub.
          connection_string   = string  - (Required) The connection string of an EventHub Namespace.
        }
    }
    ```
  EOT

  default = null
}

variable "backends" {
  type = list(object({
    name        = string
    protocol    = string
    url         = string
    resource_id = string
    description = string
    tls = object({
      validate_certificate_chain = bool
      validate_certificate_name  = bool
    })
  }))
}

variable "named_values" {
  type = list(object({
    name         = string
    display_name = string
    value        = string
    value_from_key_vault = list(object({
      secret_id          = string
      identity_client_id = string
    }))
    secret = string
    tags   = list(string)
  }))
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "Enable Diagnostic Settings."
  default     = false
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace to send Diagnostic to."
  default     = null
}