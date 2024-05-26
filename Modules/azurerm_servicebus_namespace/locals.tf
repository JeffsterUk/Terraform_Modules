locals {
  queue_auth_rules = flatten([
    for queue in var.servicebus_queues : [
      for rule in queue.queue_authorization_rules : merge(rule,
        {
          queue_name = queue.name
      })
    ]
  ])

  topic_authorization_rules = flatten([
    for topic in var.servicebus_topics != null ? var.servicebus_topics : [] : [
      for rule in topic.topic_authorization_rules != null ? topic.topic_authorization_rules : [] : merge(rule,
        {
          topic_name = topic.name
      })
    ]
  ])

  subscriptions = flatten([
    for topic in var.servicebus_topics != null ? var.servicebus_topics : [] : [
      for subscription in topic.subscriptions != null ? topic.subscriptions : [] : merge(subscription,
        {
          topic_name = topic.name
      })
    ]
  ])

  sb_subscription_rules = flatten([
    for subscription in local.subscriptions != null ? local.subscriptions : [] : [
      for rule in subscription.sb_subscription_rules != null ? subscription.sb_subscription_rules : [] : merge(rule,
        {
          subscription_name = subscription.name
      })
    ]
  ])
}