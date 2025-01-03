variable "maintenance_configuration_name" {
  type        = string
  description = "Specifies the name of the Maintenance Configuration. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Maintenance Configuration should exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "scope" {
  type        = string
  description = "The scope of the Maintenance Configuration. Possible values are Extension, Host, InGuestPatch, OSImage, SQLDB or SQLManagedInstance."
}

variable "visibility" {
  type        = string
  description = "The visibility of the Maintenance Configuration. The only allowable value is Custom. Defaults to Custom."
  default     = null
}

variable "in_guest_user_patch_mode" {
  type        = string
  description = "The in guest user patch mode. Possible values are Platform or User. Must be specified when scope is InGuestPatch."
  default     = ""
}

variable "window" {
  type = object({
    start_date_time      = string
    expiration_date_time = string
    duration             = string
    recur_every          = string
    time_zone            = string
  })

  description = <<-EOT
    A window block supports the following:

    ```
    {
      start_date_time         = string - (Required) Effective start date of the maintenance window in YYYY-MM-DD hh:mm format.
      expiration_date_time    = string - (Optional) Effective expiration date of the maintenance window in YYYY-MM-DD hh:mm format.
      duration                = string - (Optional) The duration of the maintenance window in HH:mm format.
      recur_every             = string - (Optional) The rate at which a maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules.
      time_zone               = string - (Required) The time zone for the maintenance window. A list of timezones can be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell.
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null
}

variable "install_patches_linux" {
  type = object({
    classifications_to_include    = list(string)
    package_names_mask_to_exclude = list(string)
    package_names_mask_to_include = list(string)
  })
  default = null
}
variable "install_patches_windows" {
  type = object({
    classifications_to_include = list(string)
    kb_numbers_to_exclude      = list(string)
    kb_numbers_to_include      = list(string)
  })
  default = null
}
variable "install_patches_reboot" {
  type = string
  default = ""
}

variable "maintenance_assignment_dynamic_scope_name" {
  type        = string
  description = "The name which should be used for this Dynamic Maintenance Assignment. Changing this forces a new Dynamic Maintenance Assignment to be created. The name must be unique per subscription"
}

variable "filter_locations" {
  type        = list(string)
  description = "Specifies a list of locations to scope the query to."
  default     = []
}

variable "filter_os_types" {
  type        = list(string)
  description = "Specifies a list of allowed operating systems."
  default     = []
}

variable "filter_resource_groups" {
  type        = list(string)
  description = "Specifies a list of allowed resource groups."
  default     = []
}

variable "filter_resource_types" {
  type        = list(string)
  description = "Specifies a list of allowed resources."
  default     = []
}

variable "tag_filter" {
  type        = string
  description = "Filter VMs by Any or All specified tags. Defaults to Any."
  default     = "Any"
}

variable "filter_tags" {
  type = object({
    tag    = string
    values = map(string)
  })
  description = "A mapping of tags for the VM"
  default     = null
}

variable "maintenance_assignment_virtual_machine_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default = null
}

variable "virtual_machine_id" {
  type        = string
  description = "Specifies the Virtual Machine ID to which the Maintenance Configuration will be assigned. Changing this forces a new resource to be created."
  default = null
}

variable "virtual_machine_ids" {
  type = list(string)
  default = null
}

variable "virtual_machine_name" {
  type = string
  description = "Specifies the Virtual Machine name to which the Maintenance Configuration will be assigned. Id will be generated programatically."
  default = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags which should be assigned to this Maintenance Configuration"
  default     = null
}
