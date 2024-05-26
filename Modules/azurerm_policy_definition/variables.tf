variable "policyname" {
  type        = string
  description = "The name of the policy definition. Changing this forces a new resource to be created."
}

variable "policy_type" {
  type        = string
  description = "The policy type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created."
}

variable "policymode" {
  type        = string
  description = "The policy resource manager mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data."
}

variable "display_name" {
  type        = string
  description = "The display name of the policy definition."
}

variable "description" {
  type        = string
  description = "The description of the policy definition."
  default     = null
}

variable "management_group_id" {
  type = string
}

variable "metadata" {
  type        = string
  description = "The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition."
  default     = null
}

variable "policy_rule" {
  type        = string
  description = "The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block."
  default     = null
}

variable "parameters" {
  type        = string
  description = "Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition."
  default     = null
}