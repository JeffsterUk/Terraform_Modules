/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Virtual Machine Scale Set.
  *
  */

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  lifecycle {
    ignore_changes = [
      tags["__AzureDevOpsElasticPoolTimeStamp"], # Managed by Azure DevOps
      tags["__AzureDevOpsElasticPool"],          # Managed by Azure DevOps
      instances                                  # Managed by Azure DevOps
    ]
  }
  count                           = var.os_type == "linux" ? 1 : 0
  name                            = var.vmss_name
  resource_group_name             = var.resource_group_name
  computer_name_prefix            = var.computer_name_prefix
  location                        = var.location
  sku                             = var.vmss_sku
  instances                       = var.vmss_instance_count
  disable_password_authentication = var.disable_password_authentication
  admin_username                  = var.admin_user_name
  admin_password                  = random_password.password.result
  overprovision                   = var.overprovision
  encryption_at_host_enabled      = var.encryption_at_host_enabled
  upgrade_mode                    = var.upgrade_mode
  single_placement_group          = var.single_placement_group
  platform_fault_domain_count     = var.platform_fault_domain_count
  zones                           = var.zones
  zone_balance                    = var.zone_balance
  source_image_id                 = var.source_image_id

  dynamic "source_image_reference" {
    for_each = var.vmss_image_reference != null ? [1] : []

    content {
      publisher = var.vmss_image_reference.publisher
      offer     = var.vmss_image_reference.offer
      sku       = var.vmss_image_reference.sku
      version   = var.vmss_image_reference.version
    }
  }

  os_disk {
    storage_account_type = var.vmss_os_disk.storage_account_type
    caching              = var.vmss_os_disk.caching
  }

  network_interface {
    name    = var.vmss_network_interface.name
    primary = var.vmss_network_interface.primary

    ip_configuration {
      name      = var.vmss_network_interface.ip_configuration.name
      primary   = var.vmss_network_interface.ip_configuration.primary
      subnet_id = var.subnet_id
    }
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
  tags = var.tags
}

resource "azurerm_windows_virtual_machine_scale_set" "this" {
  lifecycle {
    ignore_changes = [
      tags["__AzureDevOpsElasticPoolTimeStamp"], # Managed by Azure DevOps
      tags["__AzureDevOpsElasticPool"],          # Managed by Azure DevOps
      instances                                  # Managed by Azure DevOps
    ]
  }
  count                       = var.os_type == "windows" ? 1 : 0
  name                        = var.vmss_name
  resource_group_name         = var.resource_group_name
  computer_name_prefix        = var.computer_name_prefix
  location                    = var.location
  sku                         = var.vmss_sku
  instances                   = var.vmss_instance_count
  admin_username              = var.admin_user_name
  admin_password              = random_password.password.result
  overprovision               = var.overprovision
  encryption_at_host_enabled  = var.encryption_at_host_enabled
  upgrade_mode                = var.upgrade_mode
  single_placement_group      = var.single_placement_group
  platform_fault_domain_count = var.platform_fault_domain_count
  zones                       = var.zones
  zone_balance                = var.zone_balance
  source_image_id             = var.source_image_id

  dynamic "source_image_reference" {
    for_each = var.vmss_image_reference != null ? [1] : []

    content {
      publisher = var.vmss_image_reference.publisher
      offer     = var.vmss_image_reference.offer
      sku       = var.vmss_image_reference.sku
      version   = var.vmss_image_reference.version
    }
  }

  os_disk {
    storage_account_type = var.vmss_os_disk.storage_account_type
    caching              = var.vmss_os_disk.caching
  }

  network_interface {
    name    = var.vmss_network_interface.name
    primary = var.vmss_network_interface.primary

    ip_configuration {
      name      = var.vmss_network_interface.ip_configuration.name
      primary   = var.vmss_network_interface.ip_configuration.primary
      subnet_id = var.subnet_id
    }
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
  tags = var.tags
}

resource "azurerm_key_vault_secret" "admin_username" {
  count        = var.key_vault_id == null ? 0 : 1
  name         = "vmss-username-${var.vmss_name}"
  value        = var.admin_user_name
  key_vault_id = var.key_vault_id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.this,
    azurerm_windows_virtual_machine_scale_set.this
  ]
}

resource "azurerm_key_vault_secret" "admin_password" {
  count        = var.key_vault_id == null ? 0 : 1
  name         = "vmss-password-${var.vmss_name}"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.this,
    azurerm_windows_virtual_machine_scale_set.this
  ]
}