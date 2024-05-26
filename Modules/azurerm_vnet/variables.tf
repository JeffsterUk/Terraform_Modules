variable "name" {
  type        = string
  description = "The name of the Virtual Network."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Virtual Network and DDoS Plan (if enabled)."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used in the Virtual Network. You can supply multiple."
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

variable "dns_servers" {
  description = "Azure Network DNS addresses. If no values are specified this will default to Azure DNS."
  type        = list(string)
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
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