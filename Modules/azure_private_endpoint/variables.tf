variable "name" {
  type        = string
  description = "The name of the Private Endpoint."
}

variable "location" {
  type        = string
  description = "The location where the Private Endpoint resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Private Endpoint will be created."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where the Private Endpoint will be created."
}

variable "private_service_connection" {
  type = object({
    name                           = string
    private_connection_resource_id = string
    is_manual_connection           = optional(string, false)
    subresource_names              = list(string)
  })
  description = <<-EOT
      The private service connection block supports the following arguments:

      - name                           = String  - The name of the private service connection.
      - private_connection_resource_id = String  - The ID of the resource to connect to.
      - is_manual_connection           = Boolean - Whether the connection is manual or automatic. Defaults to false.
      - subresource_names              = List    - A list of subresources to connect to.
    EOT
}

variable "private_dns_zone_group" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  description = <<-EOT
      The private dns zone group block supports the following arguments:

      - name                 = String - The name of the private dns zone group.
      - private_dns_zone_ids = List   - A list of private dns zone IDs.
    EOT
}

variable "diagnostic_settings" {
  type = object({
    name                       = string
    log_analytics_workspace_id = string
  })
  default = null
  description = <<-EOT
      The diagnostic settings block supports the following arguments:

      - name                       = String - The name of the diagnostic settings.
      - log_analytics_workspace_id = String - The ID of the Log Analytics Workspace to send diagnostic logs to.
    EOT
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the Private Endpoint."
  default     = {}
}