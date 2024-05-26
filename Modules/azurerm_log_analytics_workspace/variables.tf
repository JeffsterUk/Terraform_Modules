variable "name" {
  type        = string
  description = "The name of the resource."
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the resources will be created."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "sku" {
  type        = string
  description = "Specifies the Sku of the Log Analytics Workspace. Possible values are `Free`, `PerNode`, `Premium`, `Standard`, `Standalone`, `Unlimited`, `CapacityReservation`, and `PerGB2018` (new Sku as of 2018-04-03)."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "The workspace data retention in days. Possible values are either `7` (`Free Tier only`) or range between `30` and `730`."
  default     = 90
}
