variable "storage_data_lake_name" {
  type        = string
  description = "The name of the data lake filesystem associated with Synapse workspace "
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Synapse workspace."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "storage_account_id" {
  type        = string
  description = "The id of the storage account associated with Synapse workspace."
}

variable "sql_administrator_login" {
  type        = string
  description = "The administrator login name for the new server."
  default     = "sqladminuser"
}

variable "sql_administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login user. Needs to comply with Azure's Password Policy."
  default     = null
}

variable "synapse_workspace_name" {
  type        = string
  description = "Specifies the name of the Synapse workspace."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "azure_ad_admin_login" {
  type        = string
  description = "The login name of the Azure AD Administrator of this Synapse Workspace."
  default     = null
}

variable "object_id" {
  type        = string
  description = " The object id of the Azure AD Administrator of this Synapse Workspace."
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "The tenant id of the Azure AD Administrator of this Synapse Workspace."
  default     = null
}

variable "managed_private_endpoint_name" {
  type        = string
  description = "Specifies the name which should be used for this Managed Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}

variable "managed_resource_group_name" {
  type        = string
  description = "The name of the managed resource group for the Synapse Workspace."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Specifies whether or not public network access is allowed for the Synapse Workspace."
  default     = true
}

variable "azuread_authentication_only" {
  type        = bool
  description = "Specifies whether or not Azure AD only authentication is allowed for the Synapse Workspace."
  default     = false
}

variable "firewall_rules" {
  type = list(object({
    rule_name        = string
    start_ip_address = string
    end_ip_address   = string
  }))
  description = ""
  default     = []
}

variable "managed_virtual_network_enabled" {
  type        = bool
  description = "Specifies whether or not Managed Virtual Network is enabled for the Synapse Workspace."
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