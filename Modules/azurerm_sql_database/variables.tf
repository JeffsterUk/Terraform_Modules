variable "database_name" {
  type        = string
  description = "The name of the Ms SQL Database."
}

variable "server_id" {
  type        = string
  description = "The id of the Ms SQL Server on which to create the database."
}

variable "collation" {
  type        = string
  description = "Specifies the collation of the database."
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "auto_pause_delay_in_minutes" {
  type        = number
  description = "Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases."
  default     = -1
}

variable "create_mode" {
  type        = string
  description = "The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary."
  default     = "Default"
}

variable "creation_source_database_id" {
  type        = string
  description = "The ID of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference."
  default     = null
}

variable "elastic_pool_id" {
  type        = string
  description = "Specifies the ID of the elastic pool containing this database."
  default     = null
}

variable "geo_backup_enabled" {
  type        = bool
  description = "A boolean that specifies if the Geo Backup Policy is enabled."
  default     = true
}

variable "license_type" {
  type        = string
  description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  default     = null
}

variable "max_size_gb" {
  type        = number
  description = "The max size of the database in gigabytes."
  default     = null
}

variable "min_capacity" {
  type        = number
  description = "Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases."
  default     = null
}

variable "restore_point_in_time" {
  type        = string
  description = "Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases."
  default     = null
}

variable "recover_database_id" {
  type        = string
  description = "The ID of the database to be recovered. This property is only applicable when the create_mode is Recovery."
  default     = null
}

variable "restore_dropped_database_id" {
  type        = string
  description = "The ID of the database to be restored. This property is only applicable when the create_mode is Restore."
  default     = null
}

variable "read_replica_count" {
  type        = number
  description = "The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases."
  default     = null
}

variable "read_scale" {
  type        = bool
  description = "If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
  default     = null
}

variable "sample_name" {
  type        = string
  description = "Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
  default     = null
}

variable "sku_name" {
  type        = string
  description = "Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created."
  default     = null
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, LRS and ZRS. The default value is GRS."
  default     = "GRS"
}

variable "zone_redundant" {
  type        = bool
  description = "Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "long_term_retention_policy" {
  type = object({
    weekly_retention  = string
    monthly_retention = string
    yearly_retention  = string
    week_of_year      = number
  })

  description = <<-EOT
  An object representing a Long Term Retention Policy. 

  A Long Term Retention Policy object adheres to the following schema:

  ```
  long_term_retention_policy = {

    weekly_retention  = string - (Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. `P1Y`, `P1M`, `P1W` or `P7D`.
    monthly_retention = string - (Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. `P1Y`, `P1M`, `P4W` or `P30D`.
    yearly_retention  = string - (Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. `P1Y`, `P12M`, `P52W` or `P365D`.
    week_of_year      = number - (Optional) The week of year to take the yearly backup in an ISO 8601 format. Value has to be between 1 and 52.
  
  }

  **NOTE**: Only one of weekly_retention or monthly_retention or yearly_retention and week_of_year may be specified. The optional properties that are not required must be explicitly set to `null`
  ```

  EOT

  default = null
}

variable "short_term_retention_policy" {
  type = object({
    retention_days = number
  })

  description = <<-EOT
  An object representing a Short Term Retention Policy. 

  A Short Term Retention Policy object adheres to the following schema:

  ```
  short_term_retention_policy = {
    retention_days = number - (Required) Point In Time Restore configuration. Value has to be between `7` and `35`.
  }
  ```
  EOT

  default = null
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
