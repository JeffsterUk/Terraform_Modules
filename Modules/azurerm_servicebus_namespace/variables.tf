variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the ServiceBus Namespace."
}

variable "name" {
  type        = string
  description = "Specifies the name of the ServiceBus Namespace resource."
}

variable "sku" {
  type        = string
  description = "Defines which tier to use. Options are `basic`, `standard` or `premium`."
}

variable "capacity" {
  type        = number
  description = "Specifies the capacity. When sku is `Premium`, `capacity` can be `1`, `2`, `4`, `8` or `16`. When sku is `Basic` or `Standard`, `capacity` can be `0` only."
  default     = null
}

variable "zone_redundant" {
  type        = bool
  description = "Whether or not this resource is zone redundant. sku needs to be Premium."
  default     = false
}

variable "local_auth_enabled" {
  type        = bool
  description = "Whether or not SAS authentication is enabled for the Service Bus namespace. Defaults to true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Is public network access enabled for the Service Bus Namespace? Defaults to true."
  default     = true
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum supported TLS version for this Service Bus Namespace. Valid values are: 1.0, 1.1 and 1.2. The current default minimum TLS version is 1.2."
  default     = "1.2"
}

variable "premium_messaging_partitions" {
  type        = number
  description = "Specifies the number messaging partitions. Only valid when sku is Premium and the minimum number is 1. Possible values include 0, 1, 2, and 4"
  default     = 1
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

variable "customer_managed_key" {
  type = object({
    key_vault_key_id                  = string
    identity_id                       = string
    infrastructure_encryption_enabled = optional(bool, null)
  })

  description = <<-EOT
  Servicebus customer_managed_key block as defined below.
  
  ```
  {
    key_vault_key_id                  = string - (Required) - The ID of the Key Vault Key which should be used to Encrypt the data in this ServiceBus Namespace.
    identity_id                       = string - (Required) - The ID of the User Assigned Identity that has access to the key.
    infrastructure_encryption_enabled = bool   - (Optional) - Used to specify whether enable Infrastructure Encryption (Double Encryption).
  }
 
  ```
  **NOTE1** - This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
  **NOTE2** - Once customer-managed key encryption has been enabled, it cannot be disabled.
  EOT  

  default = null
}

variable "namespace_authorization_rules" {
  type = list(object({
    name   = string
    listen = optional(bool, false)
    send   = optional(bool, false)
    manage = optional(bool, false)
  }))

  description = <<-EOT
  Servicebus Namespace authorization rules blocks as defined below.
  
  ```
  [
    {
      name    = string - (Required) - Specifies the name of the ServiceBus Namespace Authorization Rule resource.
      listen  = bool   - (Optional) - Grants listen access to this this Authorization Rule. Defautls to `false`
      send    = bool   - (Optional) - Grants send access to this this Authorization Rule.  Defautls to `false`
      manage  = bool   - (Optional) - Grants manage access to this this Authorization Rule. When this property is true - both `listen` and `send` must be too.  Defautls to `false`      
    }
  ]
  ```
  EOT

  default = []
}

variable "servicebus_queues" {
  type = list(object({
    name                                    = string
    lock_duration                           = optional(string, "PT1M")
    max_message_size_in_kilobytes           = optional(number, null)
    max_size_in_megabytes                   = optional(number, 1024)
    requires_duplicate_detection            = optional(bool, false)
    requires_session                        = optional(bool, false)
    default_message_ttl                     = optional(string, null)
    dead_lettering_on_message_expiration    = optional(bool, false)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    max_delivery_count                      = optional(number, 10)
    status                                  = optional(string, "Active")
    enable_batched_operations               = optional(bool, true)
    auto_delete_on_idle                     = optional(string, null)
    enable_partitioning                     = optional(bool, false)
    enable_express                          = optional(bool, false)
    forward_to                              = optional(string, null)
    forward_dead_lettered_messages_to       = optional(string, null)

    queue_authorization_rules = optional(list(object({
      name   = string
      listen = optional(bool, false)
      send   = optional(bool, false)
      manage = optional(bool, false)
    })), [])
  }))

  description = <<-EOT
  None or multiple Servicebus queue blocks as defined below.
  ```
  [ 
    {
      name                                    = string - (Required) The name of the resource group in which to create the ServiceBus Queue.
      lock_duration                           = string - (Optional) The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers. Maximum value is 5 minutes.
      max_message_size_in_kilobytes           = number - (Optional) Integer value which controls the maximum size of a message allowed on the queue for Premium SKU.
      max_size_in_megabytes                   = number - (Optional) Integer value which controls the size of memory allocated for the queue.
      requires_duplicate_detection            = bool   - (Optional) Boolean flag which controls whether the Queue requires duplicate detection.
      requires_session                        = bool   - (Optional) Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages.
      default_message_ttl                     = string - (Optional) The ISO 8601 timespan duration of the TTL of messages sent to this queue. This is the default value used when TTL is not set on message itself.
      dead_lettering_on_message_expiration    = bool   - (Optional) Boolean flag which controls whether the Queue has dead letter support when a message expires.
      duplicate_detection_history_time_window = string - (Optional) The ISO 8601 timespan duration during which duplicates can be detected. Defaults to 10 minutes (PT10M).
      max_delivery_count                      = number - (Optional) Integer value which controls when a message is automatically dead lettered.
      status                                  = string - (Optional) The Status of the Service Bus Queue. Acceptable values are `Active` or `Disabled`.
      enable_batched_operations               = bool   - (Optional) Boolean flag which controls whether server-side batched operations are enabled.
      auto_delete_on_idle                     = string - (Optional) The ISO 8601 timespan duration of the idle interval after which the Queue is automatically deleted, minimum of 5 minutes.
      enable_partitioning                     = bool   - (Optional) Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Changing this forces a new resource to be created. Defaults to `false` for `Basic` and `Standard`. For `Premium`, it MUST be set to `false`.
      enable_express                          = bool   - (Optional) Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage. Defaults to `false` for `Basic` and `Standard`. For `Premium`, it MUST be set to `false`.
      forward_to                              = string - (Optional) The name of a Queue or Topic to automatically forward messages to.
      forward_dead_lettered_messages_to       = string - (Optional) The name of a Queue or Topic to automatically forward dead lettered messages to.

      queue_authorization_rules               = list(object) - (Optional) -
      [
        {
          name       = string - (Required) Specifies the name of the Authorization Rule.
          listen     = bool   - (Optional) Grants listen access to this this Authorization Rule. Defaults to `false`
          send       = bool   - (Optional) Grants send access to this this Authorization Rule.  Defaults to `false`
          manage     = bool   - (Optional) Grants manage access to this this Authorization Rule. When this property is true - both `listen` and `send` must be too.  Defaults to `false`      
        }
      ]
    }
  ]
  ```
  **NOTE1** - Partitioning is available at entity creation for all queues and topics in Basic or Standard SKUs. It is not available for the Premium messaging SKU, but any previously existing partitioned entities in Premium namespaces continue to work as expected. 
  **NOTE2** - Service Bus Premium namespaces do not support Express Entities, so enable_express MUST be set to false.
  **NOTE3** - For queue_authorization_rules at least one of the 3 permissions above needs to be set.
  EOT

  default = []
}

variable "servicebus_topics" {
  type = list(object({
    name                                    = string
    status                                  = optional(string, "Active")
    auto_delete_on_idle                     = optional(string, null)
    default_message_ttl                     = optional(string, null)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    enable_batched_operations               = optional(bool, null)
    enable_express                          = optional(bool, null)
    enable_partitioning                     = optional(bool, false)
    max_message_size_in_kilobytes           = optional(number, null)
    max_size_in_megabytes                   = optional(number, null)
    requires_duplicate_detection            = optional(bool, false)
    support_ordering                        = optional(bool, null)

    topic_authorization_rules = optional(list(object({
      name   = string
      listen = optional(bool, false)
      send   = optional(bool, false)
      manage = optional(bool, false)
    })), [])

    subscriptions = optional(list(object({
      name                                      = string
      max_delivery_count                        = number
      auto_delete_on_idle                       = optional(string, null)
      default_message_ttl                       = optional(string, null)
      lock_duration                             = optional(string, "P0DT0H1M0S")
      dead_lettering_on_message_expiration      = optional(bool, null)
      dead_lettering_on_filter_evaluation_error = optional(bool, true)
      enable_batched_operations                 = optional(bool, null)
      requires_session                          = optional(bool, null)
      forward_to                                = optional(string, null)
      forward_dead_lettered_messages_to         = optional(string, null)
      status                                    = optional(string, "Active")
      client_scoped_subscription_enabled        = optional(bool, false)

      client_scoped_subscription = optional(object({
        client_id                               = optional(string, null)
        is_client_scoped_subscription_shareable = optional(bool, true)
        is_client_scoped_subscription_durable   = optional(bool, null)
      }), null)

      sb_subscription_rules = optional(list(object({
        name        = string
        filter_type = string
        sql_filter  = optional(string, null)
        action      = optional(string, null)

        correlation_filter = optional(object({
          content_type        = optional(string, null)
          correlation_id      = optional(string, null)
          label               = optional(string, null)
          message_id          = optional(string, null)
          reply_to            = optional(string, null)
          reply_to_session_id = optional(string, null)
          session_id          = optional(string, null)
          to                  = optional(string, null)
          properties          = optional(map(string), null)
        }), null)
      })), [])
    })), [])
  }))

  description = <<-EOT
  None or multiple Servicebus topics blocks as defined below.
  ```
  [ 
    {
      name                                    = string - (Required) Specifies the name of the ServiceBus Topic resource.
      status                                  = string - (Optional) The Status of the Service Bus Topic. Acceptable values are `Active` or `Disabled`.
      auto_delete_on_idle                     = string - (Optional) The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes (PT5M).
      default_message_ttl                     = string - (Optional) The ISO 8601 timespan duration of TTL of messages sent to this topic if no TTL value is set on the message itself.
      duplicate_detection_history_time_window = string - (Optional) The ISO 8601 timespan duration during which duplicates can be detected. Defaults to 10 minutes.
      enable_batched_operations               = bool   - (Optional) Boolean flag which controls if server-side batched operations are enabled.
      enable_express                          = bool   - (Optional) Boolean flag which controls whether Express Entities are enabled. An express topic holds a message in memory temporarily before writing it to persistent storage.
      enable_partitioning                     = bool   - (Optional) Boolean flag which controls whether to enable the topic to be partitioned across multiple message brokers.
      max_message_size_in_kilobytes           = number - (Optional) Integer value which controls the maximum size of a message allowed on the topic for Premium SKU.
      max_size_in_megabytes                   = number - (Optional) Integer value which controls the size of memory allocated for the topic.
      requires_duplicate_detection            = bool   - (Optional) Boolean flag which controls whether the Topic requires duplicate detection.
      support_ordering                        = bool   - (Optional) Boolean flag which controls whether the Topic supports ordering.
      
      topic_authorization_rules               = list(object) - (Optional)
      [
        {
          name                        = string  - (Required) - Specifies the name of the ServiceBus Topic Authorization Rule resource.
          listen                      = bool    - (Optional) - Grants listen access to this this Authorization Rule. Defautls to `false`
          send                        = bool    - (Optional) - Grants send access to this this Authorization Rule.  Defautls to `false`
          manage                      = bool    - (Optional) - Grants manage access to this this Authorization Rule. When this property is true - both `listen` and `send` must be too.  Defautls to `false`      
        }
      ]

      subscriptions                                 =  list(object) - (Optional)
      [ 
        {
          name                                      = string - (Required) Specifies the name of the ServiceBus Subscription resource.
          max_delivery_count                        = number - (Required) The maximum number of deliveries.
          auto_delete_on_idle                       = string - (Optional) The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes (PT5M).
          default_message_ttl                       = string - (Optional) The ISO 8601 timespan duration of TTL of messages sent to this topic if no TTL value is set on the message itself.
          lock_duration                             = string - (Optional) The lock duration for the subscription as an ISO 8601 duration.
          dead_lettering_on_message_expiration      = bool   - (Optional) Boolean flag which controls whether the Subscription has dead letter support when a message expires.
          dead_lettering_on_filter_evaluation_error = bool   - (Optional) Boolean flag which controls whether the Subscription has dead letter support on filter evaluation exceptions.
          enable_batched_operations                 = bool   - (Optional) Boolean flag which controls whether the Subscription supports batched operations.
          requires_session                          = bool   - (Optional) Boolean flag which controls whether this Subscription supports the concept of a session.
          forward_to                                = string - (Optional) The name of a Queue or Topic to automatically forward messages to.
          forward_dead_lettered_messages_to         = string - (Optional) The name of a Queue or Topic to automatically forward Dead Letter messages to.
          status                                    = string - (Optional) The status of the Subscription. Possible values are `Active`,`ReceiveDisabled`, or `Disabled`
          client_scoped_subscription_enabled        = bool   - (Optional) Specifies whether the subscription is scoped to a client id. Defaults to False.
          
          client_scoped_subscription                = object - (Optional) 
          {
            client_id                               = string - (Optional) Specifies the Client ID of the application that created the client-scoped subscription.
            is_client_scoped_subscription_shareable = bool   - (Optional) Specifies whether the client scoped subscription is shareable. Defaults to true
            is_client_scoped_subscription_durable   = bool   - (Optional) Specifies whether the client scoped subscription is durable. This property can only be controlled from the application side.
          }
          
          sb_subscription_rules                     = list(object) - (Optional)
          [
            {
              name                        = string - (Required) Specifies the name of the ServiceBus Subscription Rule.
              filter_type                 = string - (Required) Type of filter to be applied to a BrokeredMessage. Possible values are `SqlFilter` and `CorrelationFilter`.
              sql_filter                  = string - (Optional) Represents a filter written in SQL language-based syntax that to be evaluated against a BrokeredMessage. Required when `filter_type` is set to `SqlFilter`.
              action                      = string - (Optional) Represents set of actions written in SQL language-based syntax that is performed against a BrokeredMessage.
              correlation_filter          = Object -  (Optional) A correlation_filter block as documented below to be evaluated against a BrokeredMessage. Required when filter_type is set to `CorrelationFilter`. Set to `null` when not required. 
              {
                  content_type        = string      - (Optional) Content type of the message.
                  correlation_id      = string      - (Optional) Identifier of the correlation.
                  label               = string      - (Optional) Application specific label.
                  message_id          = string      - (Optional) Identifier of the message.
                  reply_to            = string      - (Optional) Address of the queue to reply to.
                  reply_to_session_id = string      - (Optional) Session identifier to reply to.
                  session_id          = string      - (Optional) Session identifier.
                  to                  = string      - (Optional) Address to send to.
                  properties          = map(string) - (Optional) A list of user defined properties to be included in the filter. Specified as a map of name/value pairs.
              }
            }
          ]  
        }
      ]
  ```
   **NOTE1** - In Topics Partitioning is available at entity creation for all queues and topics in Basic or Standard SKUs. It is not available for the Premium messaging SKU, but any previously existing partitioned entities in Premium namespaces continue to work as expected. 
   **NOTE2** - In Topic Authorization Rules, At least one of the 3 permissions above needs to be set.
   **NOTE3** - In Subscriptions, Client Scoped Subscription can only be used for JMS subscription (Java Message Service).
   **NOTE4** - In Subscriptions, Client ID can be null or empty, but it must match the client ID set on the JMS client application. From the Azure Service Bus perspective, a null client ID and an empty client id have the same behavior. If the client ID is set to null or empty, it is only accessible to client applications whose client ID is also set to null or empty.
   **NOTE5** - In sb_subscription_rules,  set correlation_filter to null to remove it
   **NOTE6** - In sb_subscription_rules, when creating a subscription rule of type CorrelationFilter at least one property must be set in the correlation_filter block.
    }
  ]
  
  EOT

  default = []
}

variable "private_endpoints" {
  type        = list(any)
  description = "private endpoint values of service bus"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
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