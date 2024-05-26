variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Private Endpoint resources will be created."
}

variable "name" {
  type        = string
  description = "The name of the Private Endpoint."
}

variable "private_service_connection_name" {
  type        = string
  description = "The name of the Private Service Connection."
}

variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS Zone Name."
  default     = ""
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  description = "Private DNS Zone Resource Group Name."
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Private Endpoint subnet id"
  default     = ""
}

variable "is_manual_connection" {
  type        = bool
  description = "Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner."
  default     = false
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id."
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