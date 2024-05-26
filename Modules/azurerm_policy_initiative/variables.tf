variable "policy_definition_reference" {
  type = list(object({
    policy_definition_id = string
    parameter_values     = optional(string, null)
    reference_id         = optional(string, null)
    policy_group_names   = optional(list(string), [])
  }))
}

variable "parameters" {
  type        = string
  description = "parameters"
  default     = null
}

variable "policysetDefinitionCategory" {
  type        = string
  description = "policysetDefinitionCategory"
}

variable "initiativeName" {
  type        = string
  description = "initiativeName"
}

variable "policyType" {
  type        = string
  description = "policyType"
}

variable "initiativeDisplayName" {
  type        = string
  description = "initiativeDisplayName"
}

variable "initiativeDescription" {
  type        = string
  description = "initiativeDescription"
}

variable "managementGroupId" {
  type        = string
  description = "managementGroupId"
  default     = null
}