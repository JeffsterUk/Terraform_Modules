variable "ddos_name" {
  type        = string
  description = "(Required) Specifies the name of the Network DDoS Protection Plan. Changing this forces a new resource to be created."
  default     = null
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = " (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}