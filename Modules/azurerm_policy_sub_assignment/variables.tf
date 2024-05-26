variable "subpolicyassignment_name" {
  type        = string
  description = "The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created. Cannot exceed 64 characters in length."
}

variable "policy_definition_id" {
  type        = string
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
}

variable "subscription_id" {
  type        = string
  description = "The ID of the Subscription where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created."
}

variable "description" {
  type        = string
  description = "A description which should be used for this Policy Assignment."
  default     = null
}

variable "display_name" {
  type        = string
  description = "The Display Name for this Policy Assignment."
  default     = null
}

variable "location" {
  type        = string
  description = "The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "parameters" {
  type        = string
  description = "A JSON mapping of any Parameters for this Policy."
  default     = null
}

variable "enforce" {
  type        = bool
  description = "Specifies if this Policy should be enforced or not? Defaults to true."
  default     = true
}

variable "not_scopes" {
  type        = list(any)
  description = "(Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy."
  default     = null
}

variable "category" {
  type        = string
  description = "category"
  default     = null
}

variable "non_compliance_message" {
  type = list(object({
    content                        = string
    policy_definition_reference_id = optional(string)
  }))

  description = <<-EOT
  Non compliance message has the following schema:
  ```
  [
    {
      content                        = String (Required) The non-compliance message text. When assigning policy sets (initiatives), unless policy_definition_reference_id is specified then this message will be the default for all policies.
      policy_definition_reference_id = String (Optional) When assigning policy sets (initiatives), this is the ID of the policy definition that the non-compliance message applies to.
    }
  ]
  ```
  EOT

  default = []
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  description = <<-EOT
  Identity has the following schema:
  ```
  [
    {
      type         = (Required) The Type of Managed Identity which should be added to this Policy Definition. Possible values are SystemAssigned or UserAssigned.
      identity_ids = (Optional) A list of User Managed Identity IDs which should be assigned to the Policy Definition. NOTE - This is required when type is set to UserAssigned.
    }
  ]
  ```
  EOT

  default = null
}

variable "overrides" {
  type = list(object({
    value = string
    selectors = optional(list(object({
      in     = optional(list(string))
      not_in = optional(list(string))
    })))
  }))

  description = <<-EOT
  Override has the following schema:
  ```
  [
    {
      value       = String (Required) Specifies the value to override the policy property. Possible values for policyEffect override listed policy effects.
      selectors   = list((objects{
            in     = optional(list) Specify the list of policy reference id values to filter in. NOTE -Cannot be used with not_in.
            not_in = optional(list) Specify the list of policy reference id values to filter out. NOTE -Cannot be used with in.    
      })) 
    }
  ]
  ```
  EOT

  default = []
}

variable "resource_selectors" {
  type = list(object({
    name = optional(string)
    selectors = list(object({
      kind   = string
      in     = optional(list(string))
      not_in = optional(list(string))
    }))
  }))

  description = <<-EOT
  resource_selectors has the following schema:
  ```
  [
    {
      name        = String (Optional) Specifies a name for the resource selector.
      selectors   = list((objects{
            kind   = (Required) Specifies which characteristic will narrow down the set of evaluated resources. Possible values are resourceLocation, resourceType and resourceWithoutLocation.
            in     = optional(list) Specify the list of policy reference id values to filter in. NOTE -Cannot be used with not_in.
            not_in = optional(list) Specify the list of policy reference id values to filter out. NOTE -Cannot be used with in.     
      }))
    }
  ]
  ```
  EOT

  default = []
}