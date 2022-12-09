###########################################
# azuread_conditional_access_policy vars  #
###########################################
variable "policy_display_name" {
  type        = string
  description = "The friendly name for the Conditional Access Policy."
  default     = null

  validation {
    condition     = var.policy_display_name == null || length(var.policy_display_name) > 4 && length(var.policy_display_name) <= 100
    error_message = "The policy_display_name value must be between 4-100 characters long."
  }
}

variable "state" {
  type = string

  validation {
    condition     = contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "Possible values are 'enabled','disabled','enabledForReportingButNotEnforced'."
  }
}

variable "client_app_types" {
  type        = list(string)
  description = "A list of client application types included in the policy. Possible values are: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, easSupported and other."

  validation {
    condition = alltrue([
      for type in var.client_app_types : contains(["all", "browser", "mobileAppsAndDesktopClients", "exchangeActiveSync", "easSupported", "other"], type)
    ])
    error_message = "Possible values are: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, easSupported and other."
  }
}

variable "sign_in_risk_levels" {
  type        = list(string)
  description = "A list of sign-in risk levels included in the policy. Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  default     = null

  validation {
    condition = (
      var.sign_in_risk_levels == null ? true : (
        alltrue([for level in var.sign_in_risk_levels : contains(["", "low", "medium", "high", "hidden", "none", "unknownFutureValue"], level)])
      )
    )
    error_message = "Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  }
}

variable "user_risk_levels" {
  type        = list(string)
  description = "A list of user risk levels included in the policy. Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  default     = null

  validation {
    condition = (
      var.user_risk_levels == null ? true : (
        alltrue([for level in var.user_risk_levels : contains(["", "low", "medium", "high", "hidden", "none", "unknownFutureValue"], level)])
      )
    )
    error_message = "Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  }
}

variable "included_applications" {
  type        = list(string)
  description = "A list of application Names the policy applies to, unless explicitly excluded (in excluded_applications). Can also be set to All or Office365. Cannot be specified with included_user_actions. One of included_applications or included_user_actions must be specified."
  default     = null
}

variable "excluded_applications" {
  type        = list(string)
  description = "A list of application Names explicitly excluded from the policy. Can also be set to Office365."
  default     = null
}

variable "included_user_actions" {
  type        = list(string)
  description = "A list of user actions to include. Supported values are urn:user:registerdevice and urn:user:registersecurityinfo. Cannot be specified with included_applications. One of included_applications or included_user_actions must be specified."
  default     = null

  validation {
    condition = (
      var.included_user_actions == null ? true : (
        alltrue([for action in var.included_user_actions : contains(["", "urn:user:registerdevice", "urn:user:registersecurityinfo"], action)])
      )
    )
    error_message = "Supported values are urn:user:registerdevice and urn:user:registersecurityinfo."
  }
}

variable "filter_mode" {
  type        = string
  description = "Whether to include in, or exclude from, matching devices from the policy. Supported values are include or exclude."
  default     = null

  validation {
    condition = (
      var.filter_mode == null ? true : (
        contains(["include", "exclude"], var.filter_mode)
      )
    )
    error_message = "Supported values are include or exclude."
  }
}

variable "filter_rule" {
  type        = string
  description = "Condition filter to match devices.(e.g. - device.operatingSystem eq \"Doors\"). For more information, see https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/concept-condition-filters-for-devices#supported-operators-and-device-properties-for-filters"
  default     = null
}

variable "included_locations" {
  type        = list(string)
  description = "A list of location IDs in scope of policy unless explicitly excluded. Can also be set to All, or AllTrusted."
  default = null
}

variable "excluded_locations" {
  type        = list(string)
  description = "A list of location IDs excluded from scope of policy. Can also be set to AllTrusted."
  default = null
}

variable "included_platforms" {
  type        = list(string)
  description = "A list of platforms the policy applies to, unless explicitly excluded. Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  default     = null

  validation {
    condition = (
      var.included_platforms == null ? true : (
        alltrue([
          for platform in var.included_platforms : contains(["", "all", "android", "iOS", "linux", "macOS", "windows", "windowsPhone", "unknownFutureValue"], platform)]
        )
      )
    )
    error_message = "Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }
}

variable "excluded_platforms" {
  type        = list(string)
  description = "A list of platforms explicitly excluded from the policy. Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  default     = null
  validation {
    condition = (
      var.excluded_platforms == null ? true : (
        alltrue([
          for platform in var.excluded_platforms : contains(["", "all", "android", "iOS", "linux", "macOS", "windows", "windowsPhone", "unknownFutureValue"], platform)]
        )
      )
    )
    error_message = "Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }
}

variable "included_users" {
  type        = list(string)
  description = "A list of user UPNs in scope of policy unless explicitly excluded, or None or All or GuestsOrExternalUsers."
  default     = [""]
}

variable "excluded_users" {
  type        = list(string)
  description = "A list of user UPNs excluded from scope of policy and/or GuestsOrExternalUsers."
  default     = [""]
}
variable "excluded_groups" {
  type        = list(string)
  description = "A list of group IDs excluded from scope of policy."
  default     = null
}
variable "excluded_roles" {
  type        = list(string)
  description = "A list of role IDs excluded from scope of policy."
  default     = null
}
variable "included_groups" {
  type        = list(string)
  description = "A list of group IDs in scope of policy unless explicitly excluded."
  default     = null
}
variable "included_roles" {
  type        = list(string)
  description = "A list of role IDs in scope of policy unless explicitly excluded."
  default     = null
}

variable "operator" {
  type        = string
  description = "Defines the relationship of the grant controls. Possible values are: AND, OR."

  validation {
    condition     = contains(["AND", "OR"], upper(var.operator))
    error_message = "Possible values are: AND, OR."
  }
}

variable "built_in_controls" {
  type        = list(string)
  description = "List of built-in controls required by the policy. Possible values are: block, mfa, approvedApplication, compliantApplication, compliantDevice, domainJoinedDevice, passwordChange or unknownFutureValue."

  validation {
    condition = alltrue([
      for control in var.built_in_controls : contains(["block", "mfa", "approvedApplication", "compliantApplication", "compliantDevice", "domainJoinedDevice", "passwordChange", "unknownFutureValue"], control)
    ])
    error_message = "Possible values are: block, mfa, approvedApplication, compliantApplication, compliantDevice, domainJoinedDevice, passwordChange or unknownFutureValue."
  }
}

variable "custom_authentication_factors" {
  type        = list(string)
  description = "List of custom controls IDs required by the policy."
  default     = null
}

variable "terms_of_use" {
  type        = list(string)
  description = " List of terms of use IDs required by the policy."
  default     = null
}

variable "application_enforced_restrictions_enabled" {
  type        = bool
  description = "Whether or not application enforced restrictions are enabled. Defaults to false."
  default     = false
}

variable "sign_in_frequency" {
  type        = number
  description = "Number of days or hours to enforce sign-in frequency. Required when sign_in_frequency_period is specified. Due to an API issue, removing this property forces a new resource to be created."
  default     = null
}

variable "sign_in_frequency_period" {
  type        = string
  description = "The time period to enforce sign-in frequency. Possible values are: hours or days. Due to an API issue, removing this property forces a new resource to be created."
  default     = null

  validation {
    condition = (
      var.sign_in_frequency_period == null ? true : (
        contains(["hours", "days"], var.sign_in_frequency_period)
      )
    )
    error_message = "Possible values are: hours or days."
  }
}

variable "cloud_app_security_policy" {
  type        = string
  description = "Enables cloud app security and specifies the cloud app security policy to use. Possible values are: blockDownloads, mcasConfigured, monitorOnly or unknownFutureValue."
  default     = null

  validation {
    condition = (
      var.cloud_app_security_policy == null ? true : (
        contains(["blockDownloads", "mcasConfigured", "monitorOnly", "unknownFutureValue"], var.cloud_app_security_policy)
      )
    )
    error_message = "Possible values are: blockDownloads, mcasConfigured, monitorOnly or unknownFutureValue."
  }
}

variable "persistent_browser_mode" {
  type        = string
  description = "Session control to define whether to persist cookies or not. Possible values are: always or never."
  default     = null

  validation {
    condition = (
      var.persistent_browser_mode == null ? true : (
        contains(["always", "never"], var.persistent_browser_mode)
      )
    )
    error_message = "Possible values are: always or never."
  }
}
