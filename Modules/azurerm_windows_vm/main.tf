/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Windows Virtual Machine, multiple disks, disk attachment, domain join and any number of Network Interface Cards it needs.
  *
  */

resource "random_password" "vmpassword" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "${var.name}-vmpassword"
  value        = random_password.vmpassword.result
  key_vault_id = var.key_vault_id
  content_type = "password"
}

resource "azurerm_network_interface" "nic" {
  for_each                      = { for nic in var.network_interfaces : nic.name => nic }
  name                          = each.key
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_servers                   = each.value.dns_servers
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  enable_accelerated_networking = each.value.enable_accelerated_networking
  internal_dns_name_label       = each.value.internal_dns_name_label
  tags                          = var.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration

    content {
      name                                               = ip_configuration.value.name
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id
      subnet_id                                          = ip_configuration.value.subnet_id
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id                               = ip_configuration.value.public_ip_address_id
      primary                                            = ip_configuration.value.primary
      private_ip_address                                 = ip_configuration.value.private_ip_address
    }
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  size                         = var.size
  admin_username               = var.admin_username
  admin_password               = random_password.vmpassword.result
  network_interface_ids        = [for nic in azurerm_network_interface.nic : nic.id]
  allow_extension_operations   = var.allow_extension_operations
  availability_set_id          = var.availability_set_id
  computer_name                = var.computer_name
  custom_data                  = var.custom_data
  dedicated_host_id            = var.dedicated_host_id
  enable_automatic_updates     = var.enable_automatic_updates
  encryption_at_host_enabled   = var.encryption_at_host_enabled
  eviction_policy              = var.eviction_policy
  extensions_time_budget       = var.extensions_time_budget
  license_type                 = var.license_type
  max_bid_price                = var.max_bid_price
  patch_assessment_mode        = var.patch_assessment_mode
  patch_mode                   = var.patch_mode
  platform_fault_domain        = var.platform_fault_domain
  priority                     = var.priority
  provision_vm_agent           = var.provision_vm_agent
  proximity_placement_group_id = var.proximity_placement_group_id
  source_image_id              = var.source_image_id
  tags                         = var.tags
  timezone                     = var.timezone
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  zone                         = var.zone

  os_disk {
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    disk_encryption_set_id    = var.os_disk_encryption_set_id
    disk_size_gb              = var.os_disk_size_gb
    name                      = var.os_disk_name
    write_accelerator_enabled = var.os_disk_write_accelerator_enable

    dynamic "diff_disk_settings" {
      for_each = var.os_disk_diff_disk_settings != null ? [var.os_disk_diff_disk_settings] : []

      content {
        option = diff_disk_settings.value.option
      }
    }
  }

  dynamic "additional_capabilities" {
    for_each = var.additional_capabilities != null ? [var.additional_capabilities] : []

    content {
      ultra_ssd_enabled = additional_capabilities.value.ultra_ssd_enabled
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content

    content {
      content = additional_unattend_content.value.content
      setting = additional_unattend_content.value.setting
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics != null ? [var.boot_diagnostics] : []

    content {
      storage_account_uri = boot_diagnostics.value.storage_account_uri
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "plan" {
    for_each = var.plan != null ? [var.plan] : []

    content {
      name      = plan.value.name
      product   = plan.value.product
      publisher = plan.value.publisher
    }
  }

  dynamic "secret" {
    for_each = var.secret

    content {
      key_vault_id = secret.value.key_vault_id

      dynamic "certificate" {
        for_each = secret.value.certificate

        content {
          store = certificate.value.store
          url   = certificate.value.url
        }
      }
    }
  }

  dynamic "source_image_reference" {
    for_each = local.source_image_reference != null ? [local.source_image_reference] : []

    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  dynamic "winrm_listener" {
    for_each = var.winrm_listener

    content {
      protocol        = winrm_listener.value.protocol
      certificate_url = winrm_listener.value.certificate_url
    }
  }
}

resource "azurerm_managed_disk" "disk" {
  for_each = var.additional_managed_disks != null ? { for disk in var.additional_managed_disks : disk.name => disk } : {}

  name                          = each.key
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = each.value.storage_account_type
  create_option                 = each.value.create_option
  disk_encryption_set_id        = each.value.disk_encryption_set_id
  disk_iops_read_write          = each.value.disk_iops_read_write
  disk_mbps_read_write          = each.value.disk_mbps_read_write
  disk_iops_read_only           = each.value.disk_iops_read_only
  disk_size_gb                  = each.value.disk_size_gb
  image_reference_id            = each.value.image_reference_id
  logical_sector_size           = each.value.logical_sector_size
  os_type                       = each.value.os_type
  source_resource_id            = each.value.source_resource_id
  source_uri                    = each.value.source_uri
  storage_account_id            = each.value.storage_account_id
  tier                          = each.value.tier
  max_shares                    = each.value.max_shares
  trusted_launch_enabled        = each.value.trusted_launch_enabled
  on_demand_bursting_enabled    = each.value.on_demand_bursting_enabled
  tags                          = var.tags
  network_access_policy         = each.value.network_access_policy
  disk_access_id                = each.value.disk_access_id
  public_network_access_enabled = each.value.public_network_access_enabled

  dynamic "encryption_settings" {
    for_each = each.value.encryption_settings != null ? [each.value.encryption_settings] : []

    content {

      dynamic "disk_encryption_key" {
        for_each = encryption_settings.value.disk_encryption_key != null ? [encryption_settings.value.disk_encryption_key] : []

        content {
          secret_url      = disk_encryption_key.value.secret_url
          source_vault_id = disk_encryption_key.value.source_vault_id
        }
      }

      dynamic "key_encryption_key" {
        for_each = encryption_settings.value.key_encryption_key != null ? [encryption_settings.value.key_encryption_key] : []

        content {
          key_url         = key_encryption_key.value.key_url
          source_vault_id = key_encryption_key.value.source_vault_id
        }
      }
    }
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  for_each = var.additional_managed_disks != null ? { for disk in var.additional_managed_disks : disk.name => disk } : {}

  managed_disk_id           = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id        = azurerm_windows_virtual_machine.vm.id
  lun                       = each.value.lun
  caching                   = each.value.caching
  write_accelerator_enabled = each.value.write_accelerator_enabled
}

resource "azurerm_virtual_machine_extension" "ama" {
  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = "true"
  tags                       = var.tags
}

resource "azurerm_virtual_machine_extension" "gc" {
  name                       = "AzurePolicyforWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  tags                       = var.tags
}