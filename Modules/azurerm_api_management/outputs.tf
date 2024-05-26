output "api_management" {
  value       = azurerm_api_management.api_management
  description = "Outputs the full attributes of the API Management Service."
}

output "id" {
  value       = azurerm_api_management.api_management.id
  description = "The ID of the API Management Service."
}

output "name" {
  value       = azurerm_api_management.api_management.name
  description = "The name of the API Management Service."
}

output "identity" {
  value       = azurerm_api_management.api_management.identity
  description = <<-EOT
    An identity block as defined below, which contains the Managed Service Identity information for this App Service.

    ```
    {
        principal_id - The Principal ID for the Service Principal associated with the Managed Service Identity of this App Service.
        tenant_id    - The Tenant ID for the Service Principal associated with the Managed Service Identity of this App Service.
    }
    ```
    EOT
}

output "gateway_url" {
  value       = azurerm_api_management.api_management.gateway_url
  description = "The URL of the Gateway for the API Management Service."
}

output "gateway_regional_url" {
  value       = azurerm_api_management.api_management.gateway_regional_url
  description = "The Region URL for the Gateway of the API Management Service."
}

output "additional_location" {
  value       = azurerm_api_management.api_management.additional_location
  description = <<-EOT
    Zero or more additional_location blocks as defined below;

    ```
    {
        gateway_regional_url    - The URL of the Regional Gateway for the API Management Service in the specified region.
        public_ip_addresses     - Public Static Load Balanced IP addresses of the API Management service in the additional location. Available only for Basic, Standard and Premium SKU.
        private_ip_addresses    - The Private IP addresses of the API Management Service. Available only when the API Manager instance is using Virtual Network mode.
    }
    ```
    EOT
}

output "management_api_url" {
  value       = azurerm_api_management.api_management.management_api_url
  description = "The URL for the Management API associated with this API Management service."
}

output "portal_url" {
  value       = azurerm_api_management.api_management.portal_url
  description = "The URL for the Publisher Portal associated with this API Management service."
}

output "developer_portal_url" {
  value       = azurerm_api_management.api_management.developer_portal_url
  description = "The URL for the Developer Portal associated with this API Management service."
}

output "public_ip_addresses" {
  value       = azurerm_api_management.api_management.public_ip_addresses
  description = "The Public IP addresses of the API Management Service."
}

output "private_ip_addresses" {
  value       = azurerm_api_management.api_management.private_ip_addresses
  description = "The Private IP addresses of the API Management Service."
}

output "scm_url" {
  value       = azurerm_api_management.api_management.scm_url
  description = "The URL for the SCM (Source Code Management) Endpoint associated with this API Management service."
}

output "tenant_access" {
  value       = azurerm_api_management.api_management.tenant_access
  description = <<-EOT
    The tenant_access block as defined below;

    ```
    {
        tenant_id       - The identifier for the tenant access information contract.
        primary_key     - Primary access key for the tenant access information contract.
        secondary_key   - Secondary access key for the tenant access information contract.
    }
    ```
    EOT
  sensitive   = true
}

output "api_management_logger_name" {
  value       = try(azurerm_api_management_logger.api_management_logger[0].name, "")
  description = "The Name of the API Management Logger."
}

output "api_management_logger_id" {
  value       = try(azurerm_api_management_logger.api_management_logger[0].id, "")
  description = "The id of the API Management Logger."
}