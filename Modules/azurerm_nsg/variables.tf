variable "name" {
  type        = string
  description = "The name of the Network Security Group."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Network Security Group."
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

variable "nsg_rules" {
  type = list(object({
    name                         = string
    description                  = string
    priority                     = number
    direction                    = string
    access                       = optional(string, "Allow")
    protocol                     = string
    source_port_ranges           = list(string)
    destination_port_ranges      = list(string)
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  }))
  description = "List of object representing NSG rules."
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