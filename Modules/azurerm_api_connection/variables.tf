variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the api connection."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "name" {
  type        = string
  description = "The name of the api connection"
}

variable "managed_api_name" {
  description = "The lookup name of the managed API"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}