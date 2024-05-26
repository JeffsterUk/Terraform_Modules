variable "sql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for the new server."
}

variable "connection_policy" {
  type        = string
  description = "The connection policy the server will use. Possible values are `Default`, `Proxy`, and `Redirect`. Defaults to `Default`."
  default     = null
}

variable "sql_version" {
  type        = string
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
}

variable "minimum_tls_version" {
  type        = string
  description = "The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: `1.0`, `1.1` and `1.2`."
  default     = "1.2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    tenant_id                   = string
    azuread_authentication_only = string
  })

  description = <<-EOT
  An object representing an Azure AD Administrator. 

  An Azure AD Administrator object adheres to the following schema:

  ```
  azuread_administrator = {

    login_username              = string - (Required) The login username of the Azure AD Administrator of this SQL Server.
    object_id                   = string - (Required) The object id of the Azure AD Administrator of this SQL Server.
    tenant_id                   = string - (Optional) The tenant id of the Azure AD Administrator of this SQL Server.
    azuread_authentication_only = string - (Optional) Specifies whether only AD Users and administrators (like `azuread_administrator.0.login_username`) can be used to login or also local database users (like `administrator_login`).

  }

  **NOTE**: An optional property that is not required must be explicitly set to `null`
  ```
  EOT

  default = null
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

variable "keyvault_id" {
  type        = string
  description = "keyvault sub id"
}

variable "primary_user_assigned_identity_id" {
  type        = string
  description = "identity type is user then this needed"
  default     = null
}

variable "private_endpoints" {
  type        = list(any)
  description = "private endpoint values of service bus"
  default     = []
}

variable "outbound_network_restriction_enabled" {
  type        = bool
  description = "Whether outbound network traffic is restricted for this server"
  default     = false
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