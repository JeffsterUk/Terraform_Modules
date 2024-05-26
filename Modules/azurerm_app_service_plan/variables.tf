variable "name" {
  type        = string
  description = "Specifies the name of the App Service Plan component."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "os_type" {
  type        = string
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include `Windows, Linux, and WindowsContainer`."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the App Service Plan component."
}

variable "sku_name" {
  type        = string
  description = "The SKU for the plan. Possible values include `B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1`."
}

variable "app_service_environment_id" {
  type        = string
  description = "The ID of the App Service Environment where the App Service Plan should be located."
  default     = null
}

variable "maximum_elastic_worker_count" {
  type        = string
  description = "The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  default     = null
}

variable "worker_count" {
  type        = string
  description = "The number of Workers (instances) to be allocated."
  default     = null
}

variable "per_site_scaling_enabled" {
  type        = bool
  description = "Should Per Site Scaling be enabled. "
  default     = false
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "Should the Service Plan balance across Availability Zones in the region."
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