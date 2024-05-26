/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Container Registry.
  *
  */

resource "azurerm_container_registry" "acr" {
  name                      = var.acr_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  sku                       = var.sku
  admin_enabled             = var.admin_enabled
  network_rule_set          = var.network_rule_set
  quarantine_policy_enabled = var.quarantine_policy_enabled
  tags                      = var.tags

  # NOTICE: georeplications can only be enabled when sku = "Premium"
  # georeplications {
  #   location                = var.geo_location
  #   zone_redundancy_enabled = var.zone_redundancy_enabled
  #   tags                    = var.geo_tags
  # }
  retention_policy {
    days    = var.retention_days
    enabled = var.retention_enabled
  }
  trust_policy {
    enabled = var.trust_policy_enabled
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
}
