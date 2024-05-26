/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Windows Function App.
  *
  */

resource "azurerm_windows_function_app" "windows_function_app" {
  lifecycle {
    ignore_changes = [app_settings["WEBSITE_RUN_FROM_PACKAGE"]]
  }
  name = var.name

  service_plan_id     = var.app_service_plan_id
  location            = var.location
  resource_group_name = var.resource_group_name

  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key
  storage_uses_managed_identity = true

  functions_extension_version = "~${var.function_app_version}"

  virtual_network_subnet_id = var.virtual_network_subnet_id

  app_settings = local.app_settings

  dynamic "site_config" {
    for_each = [var.site_config]
    content {
      always_on                         = lookup(site_config.value, "always_on", null)
      api_definition_url                = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id             = lookup(site_config.value, "api_management_api_id", null)
      app_command_line                  = lookup(site_config.value, "app_command_line", null)
      app_scale_limit                   = lookup(site_config.value, "app_scale_limit", null)
      default_documents                 = lookup(site_config.value, "default_documents", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      load_balancing_mode               = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode             = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version               = lookup(site_config.value, "minimum_tls_version", "1.2")
      remote_debugging_enabled          = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version          = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled  = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", false)

      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", false)

      pre_warmed_instance_count = lookup(site_config.value, "pre_warmed_instance_count", null)
      elastic_instance_minimum  = lookup(site_config.value, "elastic_instance_minimum", null)
      worker_count              = lookup(site_config.value, "worker_count", null)

      vnet_route_all_enabled = lookup(site_config.value, "vnet_route_all_enabled", var.virtual_network_subnet_id != null)

      dynamic "ip_restriction" {
        for_each = var.ip_restriction
        content {
          name                      = ip_restriction.value.name
          ip_address                = ip_restriction.value.ip_address
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
          service_tag               = ip_restriction.value.service_tag
          priority                  = ip_restriction.value.priority
          action                    = ip_restriction.value.action
          headers                   = ip_restriction.value.headers
        }
      }

      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]
        content {
          dotnet_version              = lookup(var.site_config.application_stack, "dotnet_version", null)
          use_dotnet_isolated_runtime = lookup(var.site_config.application_stack, "use_dotnet_isolated_runtime", null)

          java_version            = lookup(var.site_config.application_stack, "java_version", null)
          node_version            = lookup(var.site_config.application_stack, "node_version", null)
          powershell_core_version = lookup(var.site_config.application_stack, "powershell_core_version", null)

          use_custom_runtime = lookup(var.site_config.application_stack, "use_custom_runtime", null)
        }
      }

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? ["cors"] : []
        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }

      dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs", null) != null ? ["app_service_logs"] : []
        content {
          disk_quota_mb         = lookup(site_config.value.app_service_logs, "disk_quota_mb", null)
          retention_period_days = lookup(site_config.value.app_service_logs, "retention_period_days", null)
        }
      }
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings[*]
    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  https_only                    = var.https_only
  client_certificate_enabled    = var.client_certificate_enabled
  client_certificate_mode       = var.client_certificate_mode
  builtin_logging_enabled       = var.builtin_logging_enabled
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  key_vault_reference_identity_id = var.identity.identity_ids[0]

  tags = var.tags
}

module "function_app_private_endpoints" {
  providers = { azurerm.hub_subscription = azurerm.hub_subscription }
  source    = "../azurerm_private_endpoint"
  for_each  = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }

  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_windows_function_app.windows_function_app.id
  resource_group_name                  = var.resource_group_name
  subresource_names                    = each.value.subresource_names
  private_dns_zone_name                = each.value.private_dns_zone_name
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
  tags                                 = var.tags
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  enable_diagnostic_settings           = var.enable_diagnostic_settings
}

module "monitor_diagnostic_settings" {
  source = "../azurerm_monitor_diagnostic_setting"
  count  = var.enable_diagnostic_settings ? 1 : 0

  name                       = "${var.name}-DIAG-001"
  target_resource_id         = azurerm_windows_function_app.windows_function_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}