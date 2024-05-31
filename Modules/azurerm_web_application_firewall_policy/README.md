<!-- BEGIN_TF_DOCS -->
## Descriptions

Terraform module for the creation of a Web application Firewall Policy

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.103.1, < 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.waf_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | One or more custom\_rules blocks as defined below:<pre>[<br>    {<br>        name      = string - (Optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.<br>        priority  = number - (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.<br>        rule_type = string - (Required) Describes the type of rule.<br>        action    = string - (Required) Type of action.<br><br>        match_conditions = [ // (Required) One or more match_conditions blocks as defined below.<br>            {<br>                match_values       = list(string) - (Required) One or more match_variables blocks as defined below.<br>                operator           = string       - (Required) Describes operator to be matched.<br>                negation_condition = bool         - (Optional) Describes if this is negate condition or not.<br>                transforms         = list(string) - (Optional) A list of transformations to do before the match is attempted.<br><br>                match_variables = [<br>                    {<br>                        variable_name = string - (Required) The name of the Match Variable.<br>                        selector      = string - (Optional) Describes field of the matchVariable collection.<br>                    }<br>                ]<br>            }<br>        ]<br>    }<br>]</pre>**NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`. | <pre>list(object({<br>    name      = string<br>    priority  = number<br>    rule_type = string<br>    action    = string<br><br>    match_conditions = list(object({<br>      match_values       = list(string)<br>      operator           = string<br>      negation_condition = bool<br>      transforms         = list(string)<br><br>      match_variables = list(object({<br>        variable_name = string<br>        selector      = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource location. | `string` | n/a | yes |
| <a name="input_managed_rules"></a> [managed\_rules](#input\_managed\_rules) | A managed\_rules blocks as defined below:<pre>{<br>    exclusion = [ // (Optional) One or more exclusion block defined below.<br>        {<br>            match_variable          = string - (Required) The name of the Match Variable. Possible values: `RequestArgNames`, `RequestCookieNames`, `RequestHeaderNames`.<br>            selector                = string - (Optional) Describes field of the matchVariable collection.<br>            selector_match_operator = string - (Required) Describes operator to be matched. Possible values: `Contains`, `EndsWith`, `Equals`, `EqualsAny`, `StartsWith`.<br>        }<br>    ]<br><br>    managed_rule_set = [ // (Required) One or more managed_rule_set block defined below.<br>        {<br>            type    = string - (Optional) The rule set type. Possible values: `Microsoft_BotManagerRuleSet` and `OWASP`.<br>            version = string - (Required) The rule set version. Possible values: `0.1`, `1.0`, `2.2.9`, `3.0`, `3.1` and `3.2`.<br><br>            rule_group_override = [<br>                {<br>                    rule_group_name = string       - (Required) The name of the Rule Group.<br>                    rules = [ // (Required) One or more rules block defined below.<br>                        {<br>                            id      = string - (Required) The ID of the rule.<br>                            enabled = bool   - (Required) Describes if the rule is in enabled state or disabled state.<br>                            action  = string - (Required) The action to take when the rule is matched. Possible values: `Allow`, `AnomalyScoring`, `Block`, `Log`.<br>                        }<br>                    ]<br>                }<br>            ]<br>        }<br>    ]<br>}</pre> | <pre>object({<br>    exclusion = list(object({<br>      match_variable          = string<br>      selector                = string<br>      selector_match_operator = string<br>      excluded_rule_set = list(object({<br>        type    = string<br>        version = string<br>        rule_group = list(object({<br>          excluded_rules  = list(string)<br>          rule_group_name = string<br>        }))<br>      }))<br>    }))<br><br>    managed_rule_set = list(object({<br>      type    = string<br>      version = string<br><br>      rule_group_override = list(object({<br>        rule_group_name = string<br>        rule = object({<br>          id      = string<br>          enabled = bool<br>          action  = string<br>        })<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy. | `string` | n/a | yes |
| <a name="input_policy_settings"></a> [policy\_settings](#input\_policy\_settings) | A policy\_settings block as defined below:<pre>{<br>    enabled                     = bool   - (Optional) Describes if the policy is in enabled state or disabled state. Defaults to `true`.<br>    mode                        = string - (Optional) Describes if it is in detection mode or prevention mode at the policy level. Defaults to `Prevention`.<br>    file_upload_limit_in_mb     = number - (Optional) The File Upload Limit in MB. Accepted values are in the range `1` to `750`. Defaults to `100`<br>    request_body_check          = bool   - (Optional) Is Request Body Inspection enabled? Defaults to `true`.<br>    max_request_body_size_in_kb = number - (Optional) The Maximum Request Body Size in KB. Accepted values are in the range `8` to `128`. Defaults to `128`.<br>}</pre>**NOTE**: If a property isn't required then it must be explicitly set as `null`. | <pre>object({<br>    enabled                     = bool<br>    mode                        = string<br>    file_upload_limit_in_mb     = number<br>    request_body_check          = bool<br>    max_request_body_size_in_kb = number<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_application_firewall_policy_id"></a> [web\_application\_firewall\_policy\_id](#output\_web\_application\_firewall\_policy\_id) | n/a |

## Example
<!-- END_TF_DOCS -->