variable "name" {
  type        = string
  description = "The name of the Azure Storage Account. Name must be globally unique."
  validation {
    condition     = (length(var.name) > 2 && length(var.name) < 25 && can(regex("^[a-z0-9]+$", var.name)))
    error_message = "The storage_account_name can only contain lower case alphanumeric values and be between 3-24 characters in length."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Storage Account is created."
}

variable "location" {
  type        = string
  description = "The location/region where the resource will be created."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "The kind of Storage Acccount. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Defined the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlockStorage and FileStorage accounts only Premium is valid."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = true
  description = "Boolean flag which forces HTTPS if enabled. Defaults to true."
}

variable "hns_enabled" {
  type        = bool
  default     = false
  description = "Do you need Hierarchical NameSpace enabled. This is for DataLake Gen2 deployments."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the Storage Account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "private_endpoints" {
  type = list(object({
    name                                 = string
    private_service_connection_name      = string
    subnet_id                            = string
    subresource_names                    = list(string)
    private_dns_zone_name                = string
    private_dns_zone_resource_group_name = string
    is_manual_connection                 = bool
  }))
  description = <<-EOT
  A private_endpoints block supports the following:
  &bull; `name` = string - The name of the Private Endpoint
  &bull; `private_service_connection_name` = string - The name of the Private Service Connection.
  &bull; `subnet_id` = string - The Subnet ID where this Network Interface should be located in.
  &bull; `subresource_names` = string - A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id.
  &bull; `private_dns_zone_name` = string - Private DNS Zone Name
  &bull; `private_dns_zone_resource_group_name` = string - Private DNS Zone Resource Group Name
  &bull; `is_manual_connection` = bool - Boolean flag to specify whether the Private Endpoint requires manual approval from the remote resource owner.
  EOT
  default     = []
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled? Defaults to true."
  default     = true
}

variable "allow_nested_items_to_be_public" {
  type    = bool
  default = true
}

variable "queue_properties_logging" {
  type = object({
    delete                = bool
    read                  = bool
    write                 = bool
    version               = string
    retention_policy_days = number
  })
  default = null
}

variable "network_rules" {
  type = object({
    default_action = string
  })
  default = null
}

variable "storage_shares" {
  type = list(object({
    name  = string
    quota = number
  }))
  default     = []
  description = "A list of Storage Shares to be created in the Storage Account."
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