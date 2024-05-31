variable "name" {
  type        = string
  description = "The name of the Private DNS Zone. Must be a valid domain name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the resources will be created."
}

variable "soa_record" {
  type = object({
    email        = string
    expire_time  = number
    minimum_ttl  = number
    refresh_time = number
    retry_time   = number
    ttl          = number
  })
  default = null
}

variable "virtual_network_links" {
  type = list(object({
    name               = string
    virtual_network_id = string
  }))
  description = "List of object representing the Virtual Networks to associate to the Private endpint."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}