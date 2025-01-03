/**
  * ## Descriptions
  * 
  * Terraform module for the creation of a Maintenance Configuratiom
  */

resource "azurerm_maintenance_configuration" "maintenance_configuration" {
  name                     = var.maintenance_configuration_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  scope                    = var.scope
  visibility               = var.visibility
  in_guest_user_patch_mode = var.in_guest_user_patch_mode


  window {
    start_date_time      = var.window.start_date_time
    expiration_date_time = var.window.expiration_date_time
    duration             = var.window.duration
    recur_every          = var.window.recur_every
    time_zone            = var.window.time_zone 
  }


  install_patches {
    reboot = var.install_patches_reboot

    windows {
      classifications_to_include = var.install_patches_windows != null ? var.install_patches_windows.classifications_to_include : null
      kb_numbers_to_exclude      = var.install_patches_windows != null ? var.install_patches_windows.kb_numbers_to_exclude : null
      kb_numbers_to_include      = var.install_patches_windows != null ? var.install_patches_windows.kb_numbers_to_include : null
    }

    linux {
      classifications_to_include    = var.install_patches_linux != null ? var.install_patches_linux.classifications_to_include : null
      package_names_mask_to_exclude = var.install_patches_linux != null ? var.install_patches_linux.package_names_mask_to_exclude : null
      package_names_mask_to_include = var.install_patches_linux != null ? var.install_patches_linux.package_names_mask_to_include : null
    }
  }

  tags = var.tags
}

resource "azurerm_maintenance_assignment_dynamic_scope" "maintenance_assignment_dynamic_scope" {
  count = var.scope == "InGuestPatch" ? 1 : 0
  
  name                         = var.maintenance_assignment_dynamic_scope_name
  maintenance_configuration_id = azurerm_maintenance_configuration.maintenance_configuration.id

  filter {
    locations       = var.filter_locations
    os_types        = var.filter_os_types
    resource_groups = var.filter_resource_groups
    resource_types  = var.filter_resource_types
    tag_filter      = var.tag_filter

   
  }
}


#FOR INDIVIDUAL VMS
# resource "azurerm_maintenance_assignment_virtual_machine" "maintenance_assignment_virtual_machine" {
#   for_each = toset(var.virtual_machine_ids)
 
#   location                     = var.maintenance_assignment_virtual_machine_location
#   maintenance_configuration_id = azurerm_maintenance_configuration.maintenance_configuration.id
#   virtual_machine_id           = each.key
  
# }