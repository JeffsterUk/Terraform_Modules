variable "dns_a_record_name" {
  type        = string
  description = "The name of the DNS A Record."
}

variable "ttl" {
  type        = number
  description = "The Time To Live (TTL) of the DNS record in seconds."
  default     = 10
}

variable "private_dns_zone_name" {
  type        = string
  description = "The name of the Private DNS Zone (without a terminating dot)."
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

variable "records" {
  type        = list(string)
  description = "List of IPv4 Addresses."
}