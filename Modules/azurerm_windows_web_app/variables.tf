variable "name" {
  description = "The name of the Windows Web App."
  type        = string
}

variable "location" {
  description = "The location/region where the Windows Web App should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Windows Web App should be created."
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan to use for the Windows Web App."
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of the Virtual Network Subnet to use for the Windows Web App."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Windows Web App"
  type        = bool
  default     = false
}

variable "https_only" {
  description = "Whether the Windows Web App should only be accessible over HTTPS."
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
}

variable "app_settings" {
  description = "A map of app settings to use for the Web App."
  type        = map(string)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "private_endpoints" {
  type = list(object({
    name                                 = string
    private_service_connection_name      = string
    subnet_id                            = string
    subresource_names                    = list(string)
    private_dns_zone_name                = string
    private_dns_zone_resource_group_name = string
    is_manual_connection                 = bool
    tags                                 = map(string)
  }))
  description = <<-EOT
  A private_endpoints block supports the following:
  &bull; `name` = string - The name of the Private Endpoint
  &bull; `private_service_connection_name` = string - The name of the Private Service Connection.
  &bull; `subnet_id` = string - The Subnet ID where this Network Interface should be located in.
  &bull; `subresource_names` = string - A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id.
  &bull; `private_dns_zone_name` = string - Private DNS Zone Name
  &bull; `private_dns_zone_resource_group_name` = string - Private DNS Zone Resource Group Name
  &bull; `is_manual_connection` = bool - Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner.
  EOT
  default     = []
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "Enable Diagnostic Settings."
  default     = false
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace to send Diagnostic to."
  default     = null
}

variable "sticky_settings" {
  description = "Lists of connection strings and app settings to prevent from swapping between slots."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}