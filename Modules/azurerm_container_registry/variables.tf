variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}

variable "admin_enabled" {
  description = "Is admin account enabled"
  type        = bool
  default     = false
}

variable "network_rule_set" {
  description = "The Network Rule Set for the Container Registry"
  type        = any
  default     = null
}

variable "quarantine_policy_enabled" {
  description = "Is the quarantine policy enabled"
  type        = bool
  default     = false
}

variable "retention_days" {
  description = "The number of days to retain images for"
  type        = number
  default     = null
}

variable "retention_enabled" {
  description = "Is the retention policy enabled"
  type        = bool
  default     = false
}

variable "trust_policy_enabled" {
  description = "Is the trust policy enabled"
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
}
