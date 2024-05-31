variable "name" {
  type        = string
  description = "The name of the Private DNS Zone Link. Must be a valid domain name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the resources will be created."
}

variable "private_dns_zone_name" {
  type        = string
  description = "The name of the Private DNS zone."
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the Virtual network that needs to be connected."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}