terraform {
  required_version = ">= 1.8.2, < 2.0.0"
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 4"
    }
  }
}