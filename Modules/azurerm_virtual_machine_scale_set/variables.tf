variable "vmss_name" {
  type        = string
  description = "Name of the scale set"
}

variable "resource_group_name" {
  type        = string
  description = "name of the rescource group to deploy too"
}

variable "location" {
  type        = string
  description = "location to deploy too"
}

variable "computer_name_prefix" {
  type        = string
  description = "computer name prefix. max of 9 characters"
}

variable "vmss_sku" {
  type        = string
  description = "sku size of vms in the scale set"
}

variable "vmss_instance_count" {
  type        = number
  description = "number of vm instances to be deployed to the scale set"
  default     = 0
}

variable "disable_password_authentication" {
  type        = bool
  description = "setting enable password authentication or not on vms"
  default     = false
}

variable "admin_user_name" {
  type        = string
  description = "admin user names for vms"
}

variable "vmss_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "source_image_id" {
  type    = string
  default = null
}

variable "vmss_os_disk" {
  type = object({
    storage_account_type = string
    caching              = string
  })
  default = {
    storage_account_type = "StandardSSD_LRS"
    caching              = "ReadWrite"
  }
}

variable "vmss_network_interface" {
  type = object({
    name    = string
    primary = bool
    ip_configuration = object({
      name    = string
      primary = bool
    })
  })
  default = {
    name    = "Primary"
    primary = true
    ip_configuration = {
      name    = "Primary"
      primary = true
    }
  }
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet that the VMSS will be deployed too"
}

variable "overprovision" {
  type        = bool
  default     = false
  description = "Should Azure over-provision Virtual Machines in this Scale Set? Defaults to false."
}

variable "upgrade_mode" {
  type        = string
  default     = "Manual"
  description = "Specifies how Upgrades should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual"
}

variable "single_placement_group" {
  type        = bool
  default     = false
  description = "Should this Virtual Machine Scale Set be limited to a Single Placement Group, which means the number of instances will be capped at 100 Virtual Machines. Defaults to true"
}

variable "platform_fault_domain_count" {
  type        = number
  description = "Specifies the Platform Fault Domain in which this Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Virtual Machine to be created."
  default     = null
}

variable "zone_balance" {
  type        = bool
  default     = false
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? Defaults to false. Changing this forces a new resource to be created."
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in. Changing this forces a new resource to be created."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    identity_ids = null
    type         = "SystemAssigned"
  }
  description = "The type of Managed Identity which should be assigned to the Virtual Machine Scale Set. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned. identity_ids is required when type is set to UserAssigned"
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  default     = null
  description = "Boot Diagnostic Storage Account URI. Passing a 'null' value will utilize a Managed Storage Account to store Boot Diagnostics."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "key_vault_id" {
  type        = string
  default     = null
  description = "ID of the Key Vault to store the VMSS Credentials in."
}

variable "os_type" {
  type        = string
  description = "The type of VMSS to be created, valid values are `linux` or `windows`."
}

variable "encryption_at_host_enabled" {
  type    = bool
  default = false
}