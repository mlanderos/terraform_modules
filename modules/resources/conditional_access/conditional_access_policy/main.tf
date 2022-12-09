data "azuread_user" "included_upn" {
  for_each = contains(["None","All","GuestsOrExternalUsers"],(element(var.included_users, 0))) ? toset([]) : toset(var.included_users)
  
  user_principal_name = each.value
}

data "azuread_user" "excluded_upn" {
  for_each = var.excluded_users == [""] ? toset([]) : toset(var.excluded_users)
  
  user_principal_name = each.value
}

data "azuread_service_principal" "included_app" {
  for_each = var.included_applications == null || try(length(var.included_applications), length([""])) == 1 && (contains([var.included_applications],"All") || (contains([var.included_applications],"Office365") )) ? toset([]) : try(toset(var.included_applications),toset([]))

  display_name = each.value
}

data "azuread_service_principal" "excluded_app" {
  for_each = var.excluded_applications == null || try(length(var.excluded_applications), length([""])) == 1 && (contains([var.excluded_applications],"All") || (contains([var.excluded_applications],"Office365") )) ? toset([]) : try(toset(var.excluded_applications),toset([]))

  display_name = each.value
}

locals {
  included_upn_objectid_list = [
    for obj_id in data.azuread_user.included_upn : obj_id.object_id
  ]

  excluded_upn_objectid_list = [
    for obj_id in data.azuread_user.excluded_upn : obj_id.object_id
  ]

  included_app_appid_list = [
    for app_id in data.azuread_service_principal.included_app : app_id.application_id
  ]

  excluded_app_appid_list = [
    for app_id in data.azuread_service_principal.excluded_app : app_id.application_id
  ]
}


resource "azuread_conditional_access_policy" "conditional_access_policy" {
  display_name = var.policy_display_name
  state        = var.state

  conditions {
    client_app_types    = var.client_app_types          #required  #done
    sign_in_risk_levels = var.sign_in_risk_levels       #optional  #done
    user_risk_levels    = var.user_risk_levels          #optional  #done
    applications {                                      #required
      included_applications = var.included_applications != null ? local.included_app_appid_list : var.included_applications #optional
      excluded_applications = var.excluded_applications != null ? local.excluded_app_appid_list : var.excluded_applications #optional
      included_user_actions = var.included_user_actions #optional
    }

    dynamic "devices" {
      for_each = var.filter_mode != null ? [1] : []
      content {
        filter {
          mode = var.filter_mode #required
          rule = var.filter_rule #required
        }
      }
    }

    dynamic "locations" {
      for_each = var.included_locations != null ? [1] : []
      content {
        included_locations = var.included_locations #required
        excluded_locations = var.excluded_locations #optional
      }
    }
    dynamic "platforms" {
      for_each = var.included_platforms != null ? [1] : []

      content {
        included_platforms = var.included_platforms #required
        excluded_platforms = var.excluded_platforms #optional
      }
    }

    # At least one of included_groups, included_roles or included_users must be specified.
    users {
      included_users  = contains(["None","All","GuestsOrExternalUsers"], (element(var.included_users, 0))) ? var.included_users : local.included_upn_objectid_list #optional
      excluded_users  = var.excluded_users == [""] ? var.excluded_users : local.excluded_upn_objectid_list #optional
      excluded_groups = var.excluded_groups #optional
      excluded_roles  = var.excluded_roles  #optional
      included_groups = var.included_groups #optional
      included_roles  = var.included_roles  #optional
    }
  }

  grant_controls {
    operator                      = upper(var.operator)               #required
    built_in_controls             = var.built_in_controls             #required
    custom_authentication_factors = var.custom_authentication_factors #optional
    terms_of_use                  = var.terms_of_use                  #optional
  }

  session_controls {
    application_enforced_restrictions_enabled = var.application_enforced_restrictions_enabled #optional
    sign_in_frequency                         = var.sign_in_frequency                         #optional
    sign_in_frequency_period                  = var.sign_in_frequency_period                  #optional
    cloud_app_security_policy                 = var.cloud_app_security_policy                 #optional
    persistent_browser_mode                   = var.persistent_browser_mode                   #optional

  }
}
