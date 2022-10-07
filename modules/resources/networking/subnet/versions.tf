# declare required versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.23"
    }
  }

  experiments = [ module_variable_optional_attrs ]
}
