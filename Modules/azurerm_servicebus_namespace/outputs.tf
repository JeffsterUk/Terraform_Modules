output "servicebus_namespace" {
  value       = azurerm_servicebus_namespace.sb_namespace
  description = "Outputs the full attributes of the Servicebus Namespace."
}

output "namespace_name" {
  value       = azurerm_servicebus_namespace.sb_namespace.name
  description = "The Name of the ServiceBus Namespace."
}

output "namespace_id" {
  value       = azurerm_servicebus_namespace.sb_namespace.id
  description = "The ID of the ServiceBus Namespace."
}

output "namespace_sku" {
  value       = azurerm_servicebus_namespace.sb_namespace.sku
  description = "The SKU of the ServiceBus Namespace."
}

output "namespace_capacity" {
  value       = azurerm_servicebus_namespace.sb_namespace.capacity
  description = "The capacity of the ServiceBus Namespace."
}

output "namespace_authorization_rule_names" {
  value = { for sbn_ar in azurerm_servicebus_namespace_authorization_rule.sbn_authorization_rule :
    sbn_ar.name => {
      name = sbn_ar.name
    }
  }
  description = "The List of the Servicebus Namespace Authorization Rule Names."
}

output "namespace_authorization_rule_ids" {
  value = { for sbn_ar in azurerm_servicebus_namespace_authorization_rule.sbn_authorization_rule :
    sbn_ar.id => {
      id = sbn_ar.name
    }
  }
  description = "The List of the Servicebus Namespace Authorization Rule IDs."
}

output "queue_authorization_rule_names" {
  value = { for sbq_ar in azurerm_servicebus_queue_authorization_rule.sb_queue_authorization_rule :
    sbq_ar.name => {
      name = sbq_ar.name
    }
  }
  description = "The List of the Servicebus Queue Authorization Rule Names."
}

output "topic_authorization_rule_names" {
  value = { for sbt_ar in azurerm_servicebus_topic_authorization_rule.sbt_authorization_rule :
    sbt_ar.name => {
      name = sbt_ar.name
    }
  }
  description = "The List of the Servicebus Topic Authorization Rule Names."
}

output "subscription_rule_names" {
  value = { for sbs_r in azurerm_servicebus_subscription_rule.sb_subscription_rule :
    sbs_r.name => {
      name = sbs_r.name
    }
  }
  description = "The List of the Servicebus Subscription Rule Names."
}

output "queue_authorization_rule_ids" {
  value = { for sbq_ar in azurerm_servicebus_queue_authorization_rule.sb_queue_authorization_rule :
    sbq_ar.id => {
      id = sbq_ar.id
    }
  }
  description = "The List of the Servicebus Queue Authorization Rule IDs."
}

output "topic_authorization_rule_ids" {
  value = { for sbt_ar in azurerm_servicebus_topic_authorization_rule.sbt_authorization_rule :
    sbt_ar.id => {
      id = sbt_ar.id
    }
  }
  description = "The List of the Servicebus Topic Authorization Rule IDs."
}

output "subscription_rule_ids" {
  value = { for sbs_r in azurerm_servicebus_subscription_rule.sb_subscription_rule :
    sbs_r.id => {
      id = sbs_r.id
    }
  }
  description = "The List of the Servicebus Subscription Rule IDs."
}