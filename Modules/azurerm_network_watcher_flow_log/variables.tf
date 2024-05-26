variable "subscription_id" {
  type        = string
  description = "The id of subscription"
}

variable "network_watcher_name" {
  type        = string
  description = "The name of the Network Watcher."
}

variable "nsgname" {
  type        = string
  description = "The name of the Network Watcher."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Network Watcher was deployed."
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the Storage Account where flow logs are stored."
}

variable "enabled" {
  type        = bool
  description = "Should Network Flow Logging be Enabled?"
}

variable "location" {
  type        = string
  description = "The location where the Network Watcher Flow Log resides."
}

variable "version1" {
  type        = number
  description = "The version (version) of the flow log. Possible values are 1 and 2."
}

variable "retention_policy" {
  type = list(object({
    enabled = bool
    days    = number
  }))

  description = <<-EOT
    The schema for traffic_analytics should look like this:
    ```
    [{
      enabled = bool   - (Required) Boolean flag to enable/disable retention.
      days    = number - (Required) The number of days to retain flow log records.
    }]
    ```
    **NOTE**: If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list).
    EOT

  default = []
}

variable "traffic_analytics" {
  type = list(object({
    enabled               = bool
    workspace_id          = string
    workspace_region      = string
    workspace_resource_id = string
    interval_in_minutes   = number
  }))

  description = <<-EOT
    The schema for traffic_analytics should look like this:
    ```
    [{
      enabled               = bool   - (Required) Boolean flag to enable/disable traffic analytics.
      workspace_id          = string - (Required) The resource guid of the attached workspace.
      workspace_region      = string - (Required) The location of the attached workspace.
      workspace_resource_id = string - (Required) The resource ID of the attached workspace.
      interval_in_minutes   = number - (Optional) How frequently service should do flow analytics in minutes.
    }]
    ```
    **NOTE**: If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list).
    EOT

  default = []
}