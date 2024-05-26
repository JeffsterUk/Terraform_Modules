variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to the Application Gateway should exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the Application Gateway should exist. Changing this forces a new resource to be created."
}

variable "public_ip_allocation_method" {
  type        = string
  description = "The Azure region where the public IP should be Static or Dynamic."
}

variable "public_ip_sku" {
  type        = string
  description = "The Azure region where the public IP should be Basic or Standard."
}

variable "public_ip_name" {
  type        = string
  description = "The Azure region where the public IP Name which we use for Application gateway front end."
}

variable "name" {
  type        = string
  description = "The name of the Application Gateway. Changing this forces a new resource to be created."
}

variable "zones" {
  type        = list(string)
  description = "A collection of availability zones to spread the Application Gateway over."
  default     = []
}

variable "enable_http2" {
  type        = bool
  description = "Is HTTP2 enabled on the application gateway resource?"
  default     = false
}

variable "firewall_policy_id" {
  type        = string
  description = "The ID of the Web Application Firewall Policy."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "backend_address_pool" {
  type = list(object({
    name         = string
    fqdns        = list(string)
    ip_addresses = list(string)
  }))
  description = <<-EOT
        One or more backend_address_pool blocks as per below:
        ```
        [
            {
                name         = string       - (Required) The name of the Backend Address Pool.
                fqdns        = list(string) - (Required) A list of FQDN's which should be part of the Backend Address Pool.
                ip_addresses = list(string) - (Optional) A list of IP Addresses which should be part of the Backend Address Pool.
            }
        ]
        ```

        **NOTE1**: If a property isn't required then it must be explicitly set as an empty list or `null`.

        **NOTE2**: There is a bug where fqdns cannot be empty when it is an optional parameter on the terraform docs. A pull request has been submitted and approved [here](https://github.com/hashicorp/terraform-provider-azurerm/pull/14685). Until then `fqdns` is required.
    EOT
}

variable "backend_http_settings" {
  type = list(object({
    cookie_based_affinity               = string
    affinity_cookie_name                = string
    name                                = string
    path                                = string
    port                                = number
    probe_name                          = string
    protocol                            = string
    request_timeout                     = number
    host_name                           = string
    pick_host_name_from_backend_address = bool
    trusted_root_certificate_names      = list(string)

    authentication_certificate = list(object({
      name = string
    }))

    connection_draining = object({
      enabled           = bool
      drain_timeout_sec = number
    })
  }))

  description = <<-EOT
        One or more backend_http_settings blocks as per below:
        ```
        [
            {
                cookie_based_affinity               = string       - (Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled.
                affinity_cookie_name                = string       - (Optional) The name of the affinity cookie.
                name                                = string       - (Required) The name of the Backend HTTP Settings Collection.
                path                                = string       - (Optional) The Path which should be used as a prefix for all HTTP requests.
                port                                = number       - (Required) The port which should be used for this Backend HTTP Settings Collection.
                probe_name                          = string       - (Optional) The name of an associated HTTP Probe.
                protocol                            = string       - (Required) The Protocol which should be used. Possible values are Http and Https.
                request_timeout                     = number       - (Required) The request timeout in seconds, which must be between 1 and 86400 seconds.
                host_name                           = string       - (Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true.
                pick_host_name_from_backend_address = bool         - (Optional) Whether host header should be picked from the host name of the backend server. Defaults to false.
                trusted_root_certificate_names      = list(string) - (Optional) A list of trusted_root_certificate names.

                authentication_certificate = [ // (Optional) One or more authentication_certificate blocks.
                    {
                        name = string - (Required) The name of the Authentication Certificate.
                    }   
                ]

                connection_draining = [ // (Optional) A connection_draining block as defined below.
                    {
                        enabled           = bool   - (Required) If connection draining is enabled or not.
                        drain_timeout_sec = number - (Required) The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds.
                    }
                ]
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT
}

variable "frontend_ip_configuration" {
  type = list(object({
    name = string
    #subnet_id                       = string
    subnet_name                     = string
    private_ip_address              = string
    public_ip_address_id            = string
    private_ip_address_allocation   = string
    private_link_configuration_name = string
  }))
  description = <<-EOT
        One or more frontend_ip_configuration blocks as defined below:
        ```
        [
            {
                name                            = string - (Required) The name of the Frontend IP Configuration.
                subnet_id                       = string - (Optional) The ID of the Subnet.
                private_ip_address              = string - (Optional) The Private IP Address to use for the Application Gateway.
                public_ip_address_id            = string - (Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the [Azure documentation for public IP addresses](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-addresses#application-gateways) for details.
                private_ip_address_allocation   = string - (Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static.
                private_link_configuration_name = string - (Optional) The name of the private link configuration to use for this frontend IP configuration.
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT
}

variable "frontend_port" {
  type = list(object({
    name = string
    port = number
  }))

  description = <<-EOT
        One or more frontend_port blocks as defined below:
        ```
        [
            {
                name = string - (Required) The name of the Frontend Port.
                port = number - (Required) The port used for this Frontend Port.
            }
        ]
        ```
    EOT
}

variable "gateway_ip_configuration" {
  type = list(object({
    name = string
    #subnet_id = string
    subnet_name = string
  }))

  description = <<-EOT
        One or more gateway_ip_configuration blocks as defined below:
        ```
        [
            {
                name      = string - (Required) The Name of this Gateway IP Configuration.
                subnet_id = string - (Required) The ID of the Subnet which the Application Gateway should be connected to.
            }
        ]
        ```
    EOT
}

variable "http_listener" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    host_name                      = string
    host_names                     = list(string)
    protocol                       = string
    require_sni                    = bool
    ssl_certificate_name           = string
    firewall_policy_id             = string
    ssl_profile_name               = string

    custom_error_configuration = list(object({
      status_code           = string
      custom_error_page_url = string
    }))
  }))

  description = <<-EOT
        One or more http_listener blocks as defined below:
        ```
        [
            {
                name                           = string       - (Required) The Name of the HTTP Listener.
                frontend_ip_configuration_name = string       - (Required) The Name of the Frontend IP Configuration used for this HTTP Listener.
                frontend_port_name             = string       - (Required) The Name of the Frontend Port use for this HTTP Listener.
                host_name                      = string       - (Optional) The Hostname which should be used for this HTTP Listener. Setting this value changes Listener Type to 'Multi site'.
                host_names                     = list(string) - (Optional) A list of Hostname(s) should be used for this HTTP Listener. It allows special wildcard characters.
                protocol                       = string       - (Required) The Protocol to use for this HTTP Listener. Possible values are Http and Https.
                require_sni                    = bool         - (Optional) Should Server Name Indication be Required? Defaults to false.
                ssl_certificate_name           = string       - (Optional) The name of the associated SSL Certificate which should be used for this HTTP Listener.
                firewall_policy_id             = string       - (Optional) The ID of the Web Application Firewall Policy which should be used for this HTTP Listener.
                ssl_profile_name               = string       - (Optional) The name of the associated SSL Profile which should be used for this HTTP Listener.

                custom_error_configuration = [
                    {
                        status_code           = string - (Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502.
                        custom_error_page_url = string - (Required) Error page URL of the application gateway customer error.
                    }
                ]
            }
        ]
        ```

        **NOTE1**: If a property isn't required then it must be explicitly set as an empty list or `null`.

        **NOTE2**: The host_names and host_name are mutually exclusive and cannot both be set.
    EOT
}

variable "request_routing_rule" {
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = string
    backend_http_settings_name  = string
    redirect_configuration_name = string
    rewrite_rule_set_name       = string
    url_path_map_name           = string
    priority                    = number
  }))

  description = <<-EOT
        One or more request_routing_rule blocks as defined below:
        ```
        [
            {
                name                        = string - (Required) The Name of this Request Routing Rule.
                rule_type                   = string - (Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.
                http_listener_name          = string - (Required) The Name of the HTTP Listener which should be used for this Routing Rule.
                backend_address_pool_name   = string - (Optional) The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
                backend_http_settings_name  = string - (Optional) The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
                redirect_configuration_name = string - (Optional) The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either backend_address_pool_name or backend_http_settings_name is set.
                rewrite_rule_set_name       = string - (Optional) The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs.
                url_path_map_name           = string - (Optional) The Name of the URL Path Map which should be associated with this Routing Rule.
                priority                    = number - (Optional) Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority.
            }
        ]
        ```

        **NOTE1**: If a property isn't required then it must be explicitly set as an empty list or `null`.

        **NOTE2**: `backend_address_pool_name`, `backend_http_settings_name`, `redirect_configuration_name`, and `rewrite_rule_set_name` are applicable only when `rule_type` is `Basic`.

        **NOTE3**: If you wish to use rule `priority`, you will have to specify rule-priority field values for all the existing request routing rules. Once the rule priority field is in use, any new routing rule that is created would also need to have a rule priority field value as part of its config.
    EOT
}

variable "sku" {
  type = object({
    name     = string
    tier     = string
    capacity = number
  })

  description = <<-EOT
        A sku block supports the following:
        ```
        {
            name     = string - (Required) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2.
            tier     = string - (Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2.
            capacity = number - (Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.
        }
        ```
    EOT
}

variable "trusted_root_certificate" {
  type = list(object({
    name = string
    data = string
  }))

  description = <<-EOT
        One or more trusted_root_certificate blocks as defined below:
        ```
        [
            {
                name = string - (Required) The Name of the Trusted Root Certificate to use.
                data = string - (Required) The contents of the Trusted Root Certificate which should be used.
            }
        ]
        ```
    EOT

  default = []
}

variable "ssl_policy" {
  type = object({
    disabled_protocols   = list(string)
    policy_type          = string
    policy_name          = string
    cipher_suites        = list(string)
    min_protocol_version = string
  })

  description = <<-EOT
        A ssl policy block as defined below:
        ```
        {
            disabled_protocols   = list(string) - (Optional) A list of SSL Protocols which should be disabled on this Application Gateway. This field cannot be set when policy_name or policy_type are set. Possible values are TLSv1_0, TLSv1_1 and TLSv1_2.
            policy_type          = string       - (Optional) The Type of the Policy. This is Required when policy_name is set and cannot be set if disabled_protocols is set. Possible values are Predefined and Custom.
            policy_name          = string       - (Optional) The Name of the Policy e.g AppGwSslPolicy20170401S. Required if policy_type is set to Predefined. Possible values can change over time and are published [here](https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-ssl-policy-overview). Not compatible with disabled_protocols.
            cipher_suites        = list(string) - (Optional) A List of accepted cipher suites. This is only available when policy_type is set to Custom. Possible values are: TLS_DHE_DSS_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA256, TLS_DHE_DSS_WITH_AES_256_CBC_SHA, TLS_DHE_DSS_WITH_AES_256_CBC_SHA256, TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_RSA_WITH_AES_128_GCM_SHA256, TLS_DHE_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384, TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384, TLS_RSA_WITH_3DES_EDE_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA256, TLS_RSA_WITH_AES_128_GCM_SHA256, TLS_RSA_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA256 and TLS_RSA_WITH_AES_256_GCM_SHA384.
            min_protocol_version = string       - (Optional) The minimal TLS version. This is only available when policy_type is set to Custom. Possible values are TLSv1_0, TLSv1_1 and TLSv1_2.
        }
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT

  default = null
}

variable "probe" {
  type = list(object({
    host                                      = string
    interval                                  = number
    name                                      = string
    protocol                                  = string
    path                                      = string
    timeout                                   = number
    unhealthy_threshold                       = number
    port                                      = number
    pick_host_name_from_backend_http_settings = bool
    minimum_servers                           = number

    match = object({
      body        = string
      status_code = list(string)
    })
  }))

  description = <<-EOT
        One or more probe blocks as defined below:
        ```
        [
            {
                host                                      = string - (Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as 127.0.0.1, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true.
                interval                                  = number - (Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds.
                name                                      = string - (Required) The Name of the Probe.
                protocol                                  = string - (Required) The Protocol used for this Probe. Possible values are Http and Https.
                path                                      = string - (Required) The Path used for this Probe.
                timeout                                   = number - (Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds.
                unhealthy_threshold                       = number - (Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 seconds.
                port                                      = number - (Optional) Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only.
                pick_host_name_from_backend_http_settings = bool   - (Optional) Whether the host header should be picked from the backend http settings. Defaults to false.
                minimum_servers                           = number - (Optional) The minimum number of servers that are always marked as healthy. Defaults to 0.

                match = { // (Optional) A match block as defined below.
                    body        = string - (Optional) A snippet from the Response Body which must be present in the Response.
                    status_code = list(string) - (Optional) A list of allowed status codes for this Health Probe.
                }
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT

  default = []
}

variable "ssl_certificate" {
  type = list(object({
    name                = string
    data                = string
    password            = string
    key_vault_secret_id = string
  }))

  description = <<-EOT
        One or more ssl_certificate blocks as defined below:
        ```
        [
            {
                name                = string - (Required) The Name of the SSL certificate that is unique within this Application Gateway
                data                = string - (Optional) PFX certificate. Required if key_vault_secret_id is not set.
                password            = string - (Optional) Password for the pfx file specified in data. Required if data is set.
                key_vault_secret_id = string - (Optional) Secret Id of (base-64 encoded unencrypted pfx) Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for keyvault to use this feature. Required if data is not set.
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as `null`.
    EOT

  default = []
}

variable "url_path_map" {
  type = list(object({
    name                                = string
    default_backend_address_pool_name   = string
    default_backend_http_settings_name  = string
    default_redirect_configuration_name = string
    default_rewrite_rule_set_name       = string

    path_rule = list(object({
      name                        = string
      paths                       = list(string)
      backend_address_pool_name   = string
      backend_http_settings_name  = string
      redirect_configuration_name = string
      rewrite_rule_set_name       = string
      firewall_policy_id          = string
    }))
  }))

  description = <<-EOT
        One or more url_path_map blocks as defined below:
        ```
        [
            {
                name                                = string - (Required) The Name of the URL Path Map.
                default_backend_address_pool_name   = string - (Optional) The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
                default_backend_http_settings_name  = string - (Optional) The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
                default_redirect_configuration_name = string - (Optional) The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set.
                default_rewrite_rule_set_name       = string - (Optional) The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.

                path_rule = [ // (Required) One or more path_rule blocks as defined below.
                    {
                        name                        = string - (Required) The Name of the Path Rule.
                        paths                       = string - (Required) A list of Paths used in this Path Rule.
                        backend_address_pool_name   = string - (Optional) The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
                        backend_http_settings_name  = string - (Optional) The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
                        redirect_configuration_name = string - (Optional) The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set.
                        rewrite_rule_set_name       = string - (Optional) The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
                        firewall_policy_id          = string - (Optional) The ID of the Web Application Firewall Policy which should be used as a HTTP Listener.
                    }
                ]
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as `null`.
    EOT

  default = []
}

variable "waf_configuration" {
  type = object({
    enabled                  = bool
    firewall_mode            = string
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = number
    request_body_check       = bool
    max_request_body_size_kb = number

    disabled_rule_group = list(object({
      rule_group_name = string
      rules           = list(string)
    }))

    exclusion = list(object({
      match_variable          = string
      selector_match_operator = string
      selector                = string
    }))
  })

  description = <<-EOT
        A waf_configuration block as defined below:
        ```
        {
            enabled                  = bool         - (Required) Is the Web Application Firewall be enabled?
            firewall_mode            = string       - (Required) The Web Application Firewall Mode. Possible values are Detection and Prevention.
            rule_set_type            = string       - (Required) The Type of the Rule Set used for this Web Application Firewall. Currently, only OWASP is supported.
            rule_set_version         = string       - (Required) The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, and 3.1.
            file_upload_limit_mb     = number       - (Optional) The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB.
            request_body_check       = bool         - (Optional) Is Request Body Inspection enabled? Defaults to true.
            max_request_body_size_kb = number       - (Optional) The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB.

            disabled_rule_group [ // (Optional) one or more disabled_rule_group blocks as defined below.
                {
                    rule_group_name = string       - (Required) The rule group where specific rules should be disabled. Accepted values are: crs_20_protocol_violations, crs_21_protocol_anomalies, crs_23_request_limits, crs_30_http_policy, crs_35_bad_robots, crs_40_generic_attacks, crs_41_sql_injection_attacks, crs_41_xss_attacks, crs_42_tight_security, crs_45_trojans, General, REQUEST-911-METHOD-ENFORCEMENT, REQUEST-913-SCANNER-DETECTION, REQUEST-920-PROTOCOL-ENFORCEMENT, REQUEST-921-PROTOCOL-ATTACK, REQUEST-930-APPLICATION-ATTACK-LFI, REQUEST-931-APPLICATION-ATTACK-RFI, REQUEST-932-APPLICATION-ATTACK-RCE, REQUEST-933-APPLICATION-ATTACK-PHP, REQUEST-941-APPLICATION-ATTACK-XSS, REQUEST-942-APPLICATION-ATTACK-SQLI, REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION
                    rules           = list(string) - (Optional) A list of rules which should be disabled in that group. Disables all rules in the specified group if rules is not specified.
                }
            ]

            exclusion = [
                {
                    match_variable          = string - (Required) Match variable of the exclusion rule to exclude header, cookie or GET arguments. Possible values are RequestHeaderNames, RequestArgNames and RequestCookieNames.
                    selector_match_operator = string - (Optional) Operator which will be used to search in the variable content. Possible values are Equals, StartsWith, EndsWith, Contains. If empty will exclude all traffic on this match_variable.
                    selector                = string - (Optional) String value which will be used for the filter operation. If empty will exclude all traffic on this match_variable.
                }
            ]
        }
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT

  default = null
}

variable "custom_error_configuration" {
  type = list(object({
    status_code           = string
    custom_error_page_url = string
  }))

  description = <<-EOT
        One or more custom_error_configuration blocks as defined below:
        ```
        [
            {
                status_code           = string - (Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502
                custom_error_page_url = string - (Required) Error page URL of the application gateway customer error.
            }
        ]
        ```
    EOT

  default = []
}

variable "redirect_configuration" {
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = string
    target_url           = string
    include_path         = bool
    include_query_string = bool
  }))

  description = <<-EOT
        One or more redirect_configuration blocks as defined below:
        ```
        [
            {
                name                 = string - (Required) Unique name of the redirect configuration block.
                redirect_type        = string - (Required) The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther.
                target_listener_name = string - (Optional) The name of the listener to redirect to. Cannot be set if target_url is set.
                target_url           = string - (Optional) The Url to redirect the request to. Cannot be set if target_listener_name is set.
                include_path         = bool   - (Optional) Whether or not to include the path in the redirected Url. Defaults to false.
                include_query_string = bool   - (Optional) Whether or not to include the query string in the redirected Url. Default to false.
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as `null`.
    EOT

  default = []
}

variable "autoscale_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })

  description = <<-EOT
        A autoscale_configuration block as defined below:
        ```
        [
            {
                min_capacity = number - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
                max_capacity = number - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as `null`.
    EOT

  default = null
}

variable "rewrite_rule_set" {
  type = list(object({
    name = string

    rewrite_rule = list(object({
      name          = string
      rule_sequence = number

      condition = list(object({
        variable    = string
        pattern     = string
        ignore_case = bool
        negate      = bool
      }))

      request_header_configuration = list(object({
        header_name  = string
        header_value = string
      }))

      response_header_configuration = list(object({
        header_name  = string
        header_value = string
      }))

      url = object({
        path         = string
        query_string = string
        reroute      = bool
      })
    }))
  }))

  description = <<-EOT

    ```
    [
        {
            name = string - (Required) Unique name of the rewrite rule set block.

            rewrite_rule = [ // (Required) One or more rewrite_rule blocks as defined below.
                {
                    name          = string - (Required) Unique name of the rewrite rule block.
                    rule_sequence = number - (Required) Rule sequence of the rewrite rule that determines the order of execution in a set.

                    condition = [ // (Optional) One or more condition blocks as defined below.
                        {
                            variable    = string - (Required) The variable of the condition.
                            pattern     = string - (Required) The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.
                            ignore_case = bool   - (Optional) Perform a case in-sensitive comparison. Defaults to false.
                            negate      = bool   - (Optional) Negate the result of the condition evaluation. Defaults to false.
                        }
                    ]

                    request_header_configuration = [ // (Optional) One or more request_header_configuration blocks as defined below.
                        {
                            header_name  = string - (Required) Header name of the header configuration.
                            header_value = string - (Required) Header value of the header configuration. To delete a request header set this property to an empty string.
                        }
                    ]

                    response_header_configuration = [ // (Optional) One or more response_header_configuration blocks as defined below.
                        {
                            header_name  = string - (Required) Header name of the header configuration.
                            header_value = string - (Required) Header value of the header configuration. To delete a response header set this property to an empty string.
                        }
                    ]

                    url = { // (Optional) One url block as defined below.
                        path         = string - (Optional) The URL path to rewrite.
                        query_string = string - (Optional) The query string to rewrite. One or both of path and query_string must be specified.
                        reroute      = bool   - (Optional) Whether the URL path map should be reevaluated after this rewrite has been applied. [More info on rewrite configuration](https://docs.microsoft.com/en-us/azure/application-gateway/rewrite-http-headers-url#rewrite-configuration).
                    }
                }
            ]
        }
    ]
    ```
    EOT

  default = []
}

variable "subnet_info" {
  type        = map(string)
  default     = null
  description = "A mapping of subnet_id and subnet_name from subnet module outputs"
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the App Gateway. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to App Gateway. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
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

variable "ddos_protection_plan_name" {
  type        = string
  description = "Enable/disable DDoS Protection Plan on the VNET. This will also create a DDoS Plan if enabled."
  default     = null
}

variable "ddos_protection_plan_resource_group_name" {
  type        = string
  description = "The separator character to use in the name of the ddos protection plan, if enabled."
  default     = null
}

variable "ddos_protection_mode" {
  type        = string
  description = "ddos_protection_mode to use in the name of the ddos protection plan in Public IP, if enabled."
  default     = "Enabled"
}