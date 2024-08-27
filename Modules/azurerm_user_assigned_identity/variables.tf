variable "name" {
  type        = string
  description = "Specifies the name of the User Assigned Identity."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the User Assigned Identity component."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "role_assignments" {
  description = "A map of role assignments to assign to the User Assigned Identity."
  type = map(object({
    scope_id             = string
    role_definition_name = string
  }))
  default = {}
}

variable "federated_identity_credentials" {
  description = "A list of federated identity credentials to assign to the User Assigned Identity."
  type = list(object({
    name     = string
    audience = list(string)
    issuer   = string
    subject  = string
  }))
  default = []
}