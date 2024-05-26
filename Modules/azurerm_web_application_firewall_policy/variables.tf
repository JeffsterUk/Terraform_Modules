variable "name" {
  type        = string
  description = "The name of the policy."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "Resource location."
}

variable "custom_rules" {
  type = list(object({
    name      = string
    priority  = number
    rule_type = string
    action    = string

    match_conditions = list(object({
      match_values       = list(string)
      operator           = string
      negation_condition = bool
      transforms         = list(string)

      match_variables = list(object({
        variable_name = string
        selector      = string
      }))
    }))
  }))

  description = <<-EOT
        One or more custom_rules blocks as defined below:
        ```
        [
            {
                name      = string - (Optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.
                priority  = number - (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
                rule_type = string - (Required) Describes the type of rule.
                action    = string - (Required) Type of action.

                match_conditions = [ // (Required) One or more match_conditions blocks as defined below.
                    {
                        match_values       = list(string) - (Required) One or more match_variables blocks as defined below.
                        operator           = string       - (Required) Describes operator to be matched.
                        negation_condition = bool         - (Optional) Describes if this is negate condition or not.
                        transforms         = list(string) - (Optional) A list of transformations to do before the match is attempted.

                        match_variables = [
                            {
                                variable_name = string - (Required) The name of the Match Variable.
                                selector      = string - (Optional) Describes field of the matchVariable collection.
                            }
                        ]
                    }
                ]
            }
        ]
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
    EOT

  default = []
}

variable "policy_settings" {
  type = object({
    enabled                     = bool
    mode                        = string
    file_upload_limit_in_mb     = number
    request_body_check          = bool
    max_request_body_size_in_kb = number
  })

  description = <<-EOT
        A policy_settings block as defined below:
        ```
        {
            enabled                     = bool   - (Optional) Describes if the policy is in enabled state or disabled state. Defaults to `true`.
            mode                        = string - (Optional) Describes if it is in detection mode or prevention mode at the policy level. Defaults to `Prevention`.
            file_upload_limit_in_mb     = number - (Optional) The File Upload Limit in MB. Accepted values are in the range `1` to `750`. Defaults to `100`
            request_body_check          = bool   - (Optional) Is Request Body Inspection enabled? Defaults to `true`.
            max_request_body_size_in_kb = number - (Optional) The Maximum Request Body Size in KB. Accepted values are in the range `8` to `128`. Defaults to `128`.
        }
        ```

        **NOTE**: If a property isn't required then it must be explicitly set as `null`.
    EOT

  default = null
}

variable "managed_rules" {
  type = object({
    exclusion = list(object({
      match_variable          = string
      selector                = string
      selector_match_operator = string
      excluded_rule_set = list(object({
        type    = string
        version = string
        rule_group = list(object({
          excluded_rules  = list(string)
          rule_group_name = string
        }))
      }))
    }))

    managed_rule_set = list(object({
      type    = string
      version = string

      rule_group_override = list(object({
        rule_group_name = string
        rule = object({
          id      = string
          enabled = bool
          action  = string
        })
      }))
    }))
  })

  description = <<-EOT
        A managed_rules blocks as defined below:
        ```
        {
            exclusion = [ // (Optional) One or more exclusion block defined below.
                {
                    match_variable          = string - (Required) The name of the Match Variable. Possible values: `RequestArgNames`, `RequestCookieNames`, `RequestHeaderNames`.
                    selector                = string - (Optional) Describes field of the matchVariable collection.
                    selector_match_operator = string - (Required) Describes operator to be matched. Possible values: `Contains`, `EndsWith`, `Equals`, `EqualsAny`, `StartsWith`.
                }
            ]

            managed_rule_set = [ // (Required) One or more managed_rule_set block defined below.
                {
                    type    = string - (Optional) The rule set type. Possible values: `Microsoft_BotManagerRuleSet` and `OWASP`.
                    version = string - (Required) The rule set version. Possible values: `0.1`, `1.0`, `2.2.9`, `3.0`, `3.1` and `3.2`.

                    rule_group_override = [
                        {
                            rule_group_name = string       - (Required) The name of the Rule Group.
                            rules = [ // (Required) One or more rules block defined below.
                                {
                                    id      = string - (Required) The ID of the rule.
                                    enabled = bool   - (Required) Describes if the rule is in enabled state or disabled state.
                                    action  = string - (Required) The action to take when the rule is matched. Possible values: `Allow`, `AnomalyScoring`, `Block`, `Log`.
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        ```
    EOT
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}