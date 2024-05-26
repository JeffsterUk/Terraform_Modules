variable "name" {
  type        = string
  description = "The name of the Subnet."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the subnet."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the Virtual Network to attach the subnet to."
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the Subnet."
}

variable "service_endpoints" {
  type        = list(string)
  description = "The list of Service Endpoints to associate with the Subnet. Possible values include Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry etc."
}

variable "nsg_details" {
  type = object({
    is_nsg_subnet_association_required = bool
    nsg_id                             = string
  })
  default = {
    is_nsg_subnet_association_required = false
    nsg_id                             = null
  }
  description = "Attribute nsg_id is required if NSG-Subnet association is required."
  validation {
    condition     = (var.nsg_details.is_nsg_subnet_association_required == true && (var.nsg_details.nsg_id == null || var.nsg_details.nsg_id == "")) ? false : true
    error_message = "Attribute nsg_id can't be null or empty if is_nsg_subnet_association_required is true."
  }
  validation {
    condition     = var.nsg_details.is_nsg_subnet_association_required == null ? false : true
    error_message = "Attribute is_nsg_subnet_association_required must be either true or false."
  }
}

variable "route_table_details" {
  type = object({
    is_route_table_subnet_association_required = bool
    route_table_id                             = string
  })
  default = {
    is_route_table_subnet_association_required = false
    route_table_id                             = null
  }
  description = "Attribute route_table_id is required if RouteTable-Subnet association is required."
  validation {
    condition     = (var.route_table_details.is_route_table_subnet_association_required == true && (var.route_table_details.route_table_id == null || var.route_table_details.route_table_id == "")) ? false : true
    error_message = "Attribute route_table_id can't be null or empty if is_route_table_subnet_association_required is true."
  }
  validation {
    condition     = var.route_table_details.is_route_table_subnet_association_required == null ? false : true
    error_message = "Attribute is_route_table_subnet_association_required must be either true or false."
  }
}

variable "delegation" {
  type = list(object({
    servicename = string
    actions     = list(string)
  }))
  description = "Service delegation details for the subnet."
  default     = []
}