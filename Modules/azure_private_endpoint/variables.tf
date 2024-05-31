variable "name" {
  type        = string
  description = "The name of the Private Endpoint."
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Private Endpoint resources will be created."
}

variable "subnet_id" {
  type        = string
  description = "Private Endpoint subnet id"
  default     = ""
}

variable "private_service_connection" {
  type = object({
    name                           = string
    private_connection_resource_id = string
    is_manual_connection           = optional(string, false)
    subresource_names              = list(string)
  })
}

variable "private_dns_zone_group" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
}

variable "diagnostic_settings" {
  type = object({
    name                       = string
    log_analytics_workspace_id = string
  })
  default = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}