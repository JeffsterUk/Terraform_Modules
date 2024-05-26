variable "name" {
  description = "The name of the Function App."
  type        = string

  validation {
    condition     = length(var.name) <= 31
    error_message = "The function app name must be no longer than 31 characters."
  }
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan to use for the Function App."
  type        = string
  default     = null
}

variable "location" {
  description = "The location/region where the Function App should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Function App should be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account to use for the Function App."
  type        = string
  default     = null
}

variable "storage_account_access_key" {
  description = "The access key for the Storage Account to use for the Function App."
  type        = string
  default     = null
}

variable "storage_account_share_name" {
  description = "The name of the Storage Account File Share to use for the Function App."
  type        = string
}

variable "storage_account_share_connection_string" {
  description = "The connection string for the Storage Account File Share to use for the Function App."
  type        = string
}

variable "function_app_version" {
  description = "Version of the function app runtime to use."
  type        = number
  default     = 4
}

variable "virtual_network_subnet_id" {
  description = "The ID of the Virtual Network Subnet to use for the Function App."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "Function App application settings."
  type        = map(string)
  default     = {}
}

variable "site_config" {
  description = "Site config for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block."
  type        = any
  default     = {}
}

variable "ip_restriction" {
  description = "IP restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction."
  type        = any
  default     = {}
}

variable "sticky_settings" {
  description = "Lists of connection strings and app settings to prevent from swapping between slots."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "https_only" {
  description = "Whether HTTPS traffic only is enabled."
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Whether the Function App uses client certificates."
  type        = bool
  default     = null
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement for incoming requests. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Function App."
  type        = bool
  default     = false
}

variable "builtin_logging_enabled" {
  description = "Whether built-in logging is enabled."
  type        = bool
  default     = true
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })

  description = <<-EOT
    An object representing an Identity. 

    An Identity object adheres to the following schema:

    ```
    identity = {

      identity_type              = string       - (Required) Specifies the identity type of the Microsoft SQL Server. Currently, the only supported value is `SystemAssigned` (where Azure will generate a Service Principal for you).
      user_assigned_identity_ids = list(string) - (Optional) Specifies a list of User Assigned Identity IDs to be assigned. Required if type is `UserAssigned`.

    }

    **NOTE**: An optional property that is not required must be explicitly set to `null`
    ```
  EOT

  default = null
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