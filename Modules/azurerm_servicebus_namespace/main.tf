/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a ServiceBus Namespace.
  *
  */

resource "azurerm_servicebus_namespace" "sb_namespace" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  zone_redundant                = var.zone_redundant
  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version
  premium_messaging_partitions  = var.premium_messaging_partitions

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []

    content {
      key_vault_key_id                  = customer_managed_key.value.key_vault_key_id
      identity_id                       = customer_managed_key.value.identity_id
      infrastructure_encryption_enabled = customer_managed_key.value.infrastructure_encryption_enabled
    }
  }
  tags = var.tags
}

resource "azurerm_servicebus_namespace_authorization_rule" "sbn_authorization_rule" {
  for_each     = { for authorization_rules in var.namespace_authorization_rules : authorization_rules.name => authorization_rules }
  name         = each.key
  namespace_id = azurerm_servicebus_namespace.sb_namespace.id
  listen       = each.value.listen
  send         = each.value.send
  manage       = each.value.manage
}

resource "azurerm_servicebus_queue" "sb_queue" {
  for_each                                = { for queue in var.servicebus_queues : queue.name => queue }
  name                                    = each.key
  namespace_id                            = azurerm_servicebus_namespace.sb_namespace.id
  lock_duration                           = each.value.lock_duration
  max_message_size_in_kilobytes           = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  requires_session                        = each.value.requires_session
  default_message_ttl                     = each.value.default_message_ttl
  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  max_delivery_count                      = each.value.max_delivery_count
  status                                  = each.value.status
  enable_batched_operations               = each.value.enable_batched_operations
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  enable_partitioning                     = each.value.enable_partitioning
  enable_express                          = each.value.enable_express
  forward_to                              = each.value.forward_to
  forward_dead_lettered_messages_to       = each.value.forward_dead_lettered_messages_to
}

resource "azurerm_servicebus_queue_authorization_rule" "sb_queue_authorization_rule" {
  for_each = { for rule in local.queue_auth_rules : rule.name => rule }
  name     = each.key
  queue_id = azurerm_servicebus_queue.sb_queue[each.value.queue_name].id
  listen   = each.value.listen
  send     = each.value.send
  manage   = each.value.manage
}

resource "azurerm_servicebus_topic" "sb_topic" {
  for_each                                = { for topic in var.servicebus_topics : topic.name => topic }
  name                                    = each.key
  namespace_id                            = azurerm_servicebus_namespace.sb_namespace.id
  status                                  = each.value.status
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  default_message_ttl                     = each.value.default_message_ttl
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  enable_batched_operations               = each.value.enable_batched_operations
  enable_express                          = each.value.enable_express
  enable_partitioning                     = each.value.enable_partitioning
  max_message_size_in_kilobytes           = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  support_ordering                        = each.value.support_ordering
}

resource "azurerm_servicebus_topic_authorization_rule" "sbt_authorization_rule" {
  for_each = { for authorization_rule in local.topic_authorization_rules : authorization_rule.name => authorization_rule }
  name     = each.key
  topic_id = azurerm_servicebus_topic.sb_topic[each.value.topic_name].id
  listen   = each.value.listen
  send     = each.value.send
  manage   = each.value.manage
}

resource "azurerm_servicebus_subscription" "sb_subscription" {
  for_each                                  = { for subscription in local.subscriptions : subscription.name => subscription }
  name                                      = each.key
  topic_id                                  = azurerm_servicebus_topic.sb_topic[each.value.topic_name].id
  max_delivery_count                        = each.value.max_delivery_count
  auto_delete_on_idle                       = each.value.auto_delete_on_idle
  default_message_ttl                       = each.value.default_message_ttl
  lock_duration                             = each.value.lock_duration
  dead_lettering_on_message_expiration      = each.value.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = each.value.dead_lettering_on_filter_evaluation_error
  enable_batched_operations                 = each.value.enable_batched_operations
  requires_session                          = each.value.requires_session
  forward_to                                = each.value.forward_to
  forward_dead_lettered_messages_to         = each.value.forward_dead_lettered_messages_to
  status                                    = each.value.status
  client_scoped_subscription_enabled        = each.value.client_scoped_subscription_enabled

  dynamic "client_scoped_subscription" {
    for_each = each.value.client_scoped_subscription != null ? [each.value.client_scoped_subscription] : []

    content {
      client_id                               = client_scoped_subscription.value.client_id
      is_client_scoped_subscription_shareable = client_scoped_subscription.value.is_client_scoped_subscription_shareable
      is_client_scoped_subscription_durable   = client_scoped_subscription.value.is_client_scoped_subscription_durable
    }
  }
}

resource "azurerm_servicebus_subscription_rule" "sb_subscription_rule" {
  for_each        = { for rule in local.sb_subscription_rules : rule.name => rule }
  name            = each.key
  subscription_id = azurerm_servicebus_subscription.sb_subscription[each.value.subscription_name].id
  filter_type     = each.value.filter_type
  sql_filter      = each.value.sql_filter
  action          = each.value.action

  dynamic "correlation_filter" {
    for_each = each.value.correlation_filter != null ? [each.value.correlation_filter] : []

    content {
      content_type        = correlation_filter.value.content_type
      correlation_id      = correlation_filter.value.correlation_id
      label               = correlation_filter.value.label
      message_id          = correlation_filter.value.message_id
      reply_to            = correlation_filter.value.reply_to
      reply_to_session_id = correlation_filter.value.reply_to_session_id
      session_id          = correlation_filter.value.session_id
      to                  = correlation_filter.value.to
      properties          = correlation_filter.value.properties
    }
  }
}

module "private_endpoints" {
  providers                            = { azurerm.hub_subscription = azurerm.hub_subscription }
  source                               = "../azurerm_private_endpoint"
  for_each                             = { for private_endpoint in var.private_endpoints : private_endpoint.name => private_endpoint }
  name                                 = each.key
  private_service_connection_name      = each.value.private_service_connection_name
  subnet_id                            = each.value.subnet_id
  is_manual_connection                 = each.value.is_manual_connection
  location                             = var.location
  private_connection_resource_id       = azurerm_servicebus_namespace.sb_namespace.id
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
  target_resource_id         = azurerm_servicebus_namespace.sb_namespace.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}