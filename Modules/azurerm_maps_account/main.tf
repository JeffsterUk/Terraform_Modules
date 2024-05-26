/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Maps Account.
  *
  */

resource "azapi_resource" "maps_account" {
  type      = "Microsoft.Maps/accounts@2023-06-01"
  name      = var.name
  location  = var.maps_account_location
  parent_id = var.resource_group_id
  tags      = var.tags
  identity {
    type         = "UserAssigned"
    identity_ids = [module.user_assigned_identity.id]
  }
  body = jsonencode({
    properties = {
      cors = {
        corsRules = [
          {
            allowedOrigins = []
          }
        ]
      }
      disableLocalAuth = var.disable_local_authentication
    }
    sku = {
      name = var.sku_name
    }
    kind = var.kind
  })
}

module "user_assigned_identity" {
  source              = "../azurerm_user_assigned_identity"
  location            = var.user_assigned_identity_location
  name                = var.user_assigned_identity_name
  resource_group_name = var.resource_group_name
  role_assignments    = var.user_assigned_identity_role_assignments
  tags                = var.tags
}
