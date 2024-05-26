variable "name" {
  type        = string
  description = "The name of the Private DNS Zone. Must be a valid domain name."
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

variable "virtual_networks" {
  type = list(object({
    name                = string
    resource_group_name = string
  }))
  description = "List of object representing the Virtual Networks to associate to the Private endpint."
  default     = []
}

variable "email" {
  type        = string
  description = "The email contact for the SOA record."
  default     = "azureprivatedns-host.microsoft.com"
}

variable "expire_time" {
  type        = number
  description = "The expire time for the SOA record."
  default     = 2419200
}

variable "minimum_ttl" {
  type        = number
  description = "The minimum Time to Live for the SOA record. It is used to determine the negative caching duration."
  default     = 300
}

variable "refresh_time" {
  type        = number
  description = "The refresh time for the SOA record."
  default     = 3600
}

variable "retry_time" {
  type        = number
  description = "The retry time for the SOA record."
  default     = 300
}

variable "ttl" {
  type        = number
  description = "The Time to Live of the SOA Record in seconds."
  default     = 3600
}

variable "update_soarecord" {
  type        = bool
  description = "If set to true, SOA record defaults will be changed."
  default     = false
}