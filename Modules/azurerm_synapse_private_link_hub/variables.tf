variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Synapse workspace."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "name" {
  type        = string
  description = "The name of the Synapse Private Link Hub."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet in which to create the Synapse Private Link Hub Private Endpoint"
}

variable "private_dns_zone_name" {
  type        = string
  description = "The name of the private DNS zone to use for the private endpoint connection."
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the private DNS zone is located."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace to send Diagnostic to."
  default     = null
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "Enable diagnostic settings for the Synapse Private Endpoint."
  default     = false
}