terraform {
  required_version = ">= 1.8.2, < 2.0.0"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13.1, < 2.0.0"
    }
  }
}