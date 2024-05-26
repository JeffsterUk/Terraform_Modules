variable "name" {
  type        = string
  description = "Specifies the name of the Public IP resource . Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the public ip."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "ip_version" {
  type        = string
  description = "The IP Version to use, `IPv6` or `IPv4`."
  default     = "IPv4"
}

variable "sku" {
  type        = string
  description = <<-EOT
    The SKU of the Public IP. Accepted values are `Basic` and `Standard`.  
    **NOTE**: Public IP Standard SKUs require `allocation_method` to be set to `Static`.
  EOT

  default = "Basic"
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global`."
  default     = "Regional"
}

variable "idle_timeout_in_minutes" {
  type        = string
  description = "Specifies the timeout for the TCP idle connection. The value can be set between `4` and `30` minutes."
  default     = null
}

variable "domain_name_label" {
  type        = string
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
}

variable "reverse_fqdn" {
  type        = string
  description = "A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  default     = null
}

variable "public_ip_prefix_id" {
  type        = string
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource."
  default     = null
}

variable "ip_tags" {
  type        = map(string)
  description = "A mapping of IP tags to assign to the public IP."
  default     = null
}

variable "zones" {
  type        = list(string)
  description = "A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  default     = null
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "Enable Diagnostic Settings."
  default     = false
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace to send Diagnostic to."
  default     = null
}