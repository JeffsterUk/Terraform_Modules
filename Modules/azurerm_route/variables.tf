variable "route_table_name" {
  type        = string
  description = "The name of the Route Table."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Route Table."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  default     = false
  description = "Boolean flag which controls propagation of routes learned by BGP on the Route Table."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "routes" {
  type = list(object({
    route_name             = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
  description = "A list of objects representing routes."
}