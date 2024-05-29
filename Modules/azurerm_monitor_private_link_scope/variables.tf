variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "private_endpoint" {
  type = object({
    name = string
    location = string
    subnet_id = string
    custom_network_interface_name = string
    private_service_connection_name = string
    private_dns_zone_ids = list(string)
  })  
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "scoped_services" {
  type = list(object({
    name = string
    id = string
  }))
  description = "A list of scoped services to associate with the private link scope."
}