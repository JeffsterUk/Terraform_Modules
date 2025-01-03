locals {
  app_settings = merge(
    var.storage_account_share_name != null ? { WEBSITE_CONTENTSHARE = var.storage_account_share_name } : {},
    var.storage_account_share_connection_string != null ? { WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = var.storage_account_share_connection_string } : {},
    var.app_settings
  )
}