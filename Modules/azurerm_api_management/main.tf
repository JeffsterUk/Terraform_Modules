/**
  * ## Descriptions
  * 
  * Terraform module for the creation of an API Management Service with an option to configure a Logger within an API Management Service.
  *
  */

resource "azurerm_public_ip" "api_management_pip" {
  count               = var.public_ip_name == null ? 0 : 1
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.public_ip_name
  domain_name_label   = var.public_ip_domain_name_label
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

resource "azurerm_api_management" "api_management" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = var.sku_name
  client_certificate_enabled    = var.client_certificate_enabled
  gateway_disabled              = var.gateway_disabled
  min_api_version               = var.min_api_version
  zones                         = var.zones
  notification_sender_email     = var.notification_sender_email
  virtual_network_type          = var.virtual_network_type
  public_network_access_enabled = var.public_network_access_enabled
  public_ip_address_id          = var.virtual_network_type != null ? azurerm_public_ip.api_management_pip[0].id : null
  tags                          = var.tags

  dynamic "additional_location" {
    for_each = var.additional_location

    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      zones                = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id
      gateway_disabled     = additional_location.value.gateway_disabled

      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.virtual_network_configuration != null ? [additional_location.value.virtual_network_configuration] : []
        content {
          subnet_id = virtual_network_configuration.value.subnet_id
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = var.certificate != null ? var.certificate : []

    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = certificate.value.certificate_password
    }
  }

  dynamic "delegation" {
    for_each = var.delegation != null ? [var.delegation] : []

    content {
      subscriptions_enabled     = delegation.value.subscriptions_enabled
      user_registration_enabled = delegation.value.user_registration_enabled
      url                       = delegation.value.url
      validation_key            = delegation.value.validation_key
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.hostname_configuration != null ? [var.hostname_configuration] : []

    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management != null ? hostname_configuration.value.management : []

        content {
          host_name                       = management.value.host_name
          key_vault_id                    = management.value.key_vault_id
          certificate                     = management.value.certificate
          certificate_password            = management.value.certificate_password
          negotiate_client_certificate    = management.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = management.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "portal" {
        for_each = hostname_configuration.value.portal != null ? hostname_configuration.value.portal : []

        content {
          host_name                       = portal.value.host_name
          key_vault_id                    = portal.value.key_vault_id
          certificate                     = portal.value.certificate
          certificate_password            = portal.value.certificate_password
          negotiate_client_certificate    = portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = portal.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "developer_portal" {
        for_each = hostname_configuration.value.developer_portal != null ? hostname_configuration.value.developer_portal : []

        content {
          host_name                       = developer_portal.value.host_name
          key_vault_id                    = developer_portal.value.key_vault_id
          certificate                     = developer_portal.value.certificate
          certificate_password            = developer_portal.value.certificate_password
          negotiate_client_certificate    = developer_portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = developer_portal.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy != null ? hostname_configuration.value.proxy : []

        content {
          default_ssl_binding             = proxy.value.default_ssl_binding
          host_name                       = proxy.value.host_name
          key_vault_id                    = proxy.value.key_vault_id
          certificate                     = proxy.value.certificate
          certificate_password            = proxy.value.certificate_password
          negotiate_client_certificate    = proxy.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = proxy.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "scm" {
        for_each = hostname_configuration.value.scm != null ? hostname_configuration.value.scm : []

        content {
          host_name                       = scm.value.host_name
          key_vault_id                    = scm.value.key_vault_id
          certificate                     = scm.value.certificate
          certificate_password            = scm.value.certificate_password
          negotiate_client_certificate    = scm.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = scm.value.ssl_keyvault_identity_client_id
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }

  dynamic "policy" {
    for_each = var.policy != null ? [var.policy] : []

    content {
      xml_content = policy.value.xml_content
      xml_link    = policy.value.xml_link
    }
  }

  dynamic "protocols" {
    for_each = var.protocols != null ? [var.protocols] : []

    content {
      enable_http2 = protocols.value.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.security != null ? [var.security] : []

    content {
      enable_backend_ssl30                                = security.value.enable_backend_ssl30
      enable_backend_tls10                                = security.value.enable_backend_tls10
      enable_backend_tls11                                = security.value.enable_backend_tls11
      enable_frontend_ssl30                               = security.value.enable_frontend_ssl30
      enable_frontend_tls10                               = security.value.enable_frontend_tls10
      enable_frontend_tls11                               = security.value.enable_frontend_tls11
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = security.value.tls_rsa_with_aes256_gcm_sha384_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled                          = security.value.triple_des_ciphers_enabled
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in != null ? [var.sign_in] : []

    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up != null ? [var.sign_up] : []

    content {
      enabled = sign_up.value.enabled

      dynamic "terms_of_service" {
        for_each = [sign_up.value.terms_of_service]

        content {
          consent_required = terms_of_service.value.consent_required
          enabled          = terms_of_service.value.enabled
          text             = terms_of_service.value.text
        }
      }
    }
  }

  dynamic "tenant_access" {
    for_each = var.tenant_access != null ? [var.tenant_access] : []

    content {
      enabled = tenant_access.value.enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type != null ? [var.virtual_network_configuration] : []

    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }
}

resource "azurerm_api_management_logger" "api_management_logger" {
  count               = var.apim_logger_details == null ? 0 : 1
  name                = var.apim_logger_details.name
  buffered            = var.apim_logger_details.buffered
  description         = var.apim_logger_details.description
  resource_id         = var.apim_logger_details.resource_id
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.api_management.name

  dynamic "application_insights" {
    for_each = var.apim_logger_details.application_insights != null ? [var.apim_logger_details.application_insights] : []

    content {
      instrumentation_key = application_insights.value.instrumentation_key
    }
  }

  dynamic "eventhub" {
    for_each = var.apim_logger_details.eventhub != null ? [var.apim_logger_details.eventhub] : []

    content {
      name              = eventhub.value.name
      connection_string = eventhub.value.connection_string
    }
  }
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_api_management.api_management.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

resource "azurerm_api_management_named_value" "api_management_named_value" {
  for_each            = { for named_value in var.named_values : named_value.name => named_value }
  name                = each.value.name
  resource_group_name = azurerm_api_management.api_management.resource_group_name
  api_management_name = azurerm_api_management.api_management.name
  display_name        = each.value.display_name
  value               = each.value.value
  dynamic "value_from_key_vault" {
    for_each = each.value.value_from_key_vault

    content {
      secret_id          = value_from_key_vault.value.secret_id
      identity_client_id = value_from_key_vault.value.identity_client_id
    }
  }
  secret = each.value.secret
  tags   = each.value.tags
}

resource "azurerm_api_management_backend" "api_management_backend" {
  for_each            = { for backend in var.backends : backend.name => backend }
  name                = each.value.name
  resource_group_name = azurerm_api_management.api_management.resource_group_name
  api_management_name = azurerm_api_management.api_management.name
  protocol            = each.value.protocol
  url                 = each.value.url
  resource_id         = each.value.resource_id
  description         = each.value.description
  dynamic "tls" {
    for_each = [each.value.tls]

    content {
      validate_certificate_chain = tls.value.validate_certificate_chain
      validate_certificate_name  = tls.value.validate_certificate_name
    }
  }
}