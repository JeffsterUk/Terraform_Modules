variable "name" {
  type        = string
  description = "Specifies the name of the Azure Maps Account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the User Assigned Identity component."
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the resource group in which to create the App Service Plan component."
}

variable "sku_name" {
  type        = string
  description = "The SKU of the Azure Maps Account. Possible values are S0, S1 and G2. Changing this forces a new resource to be created."
}

variable "kind" {
  type        = string
  description = "The kind of the Azure Maps Account. Possible values are Gen1 and Gen2."
  default     = "Gen2"
}

variable "disable_local_authentication" {
  type        = bool
  description = "Specifies whether to disable local authentication for the Azure Maps Account."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "user_assigned_identity_name" {
  type        = string
  description = "The name of the user assigned identity."
}

variable "user_assigned_identity_location" {
  type        = string
  description = "The location of the user assigned identity."
}

variable "user_assigned_identity_role_assignments" {
  description = "A map of role assignments to assign to the Azure Maps Account."
  type = map(object({
    scope_id             = string
    role_definition_name = string
  }))
  default = {}
}

variable "maps_account_location" {
  type        = string
  description = "The location of the Azure Maps Account."
}
