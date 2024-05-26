output "name" {
  value       = azurerm_mssql_server.sql_server.name
  description = "The name of the Azure SQL Server."
}

output "id" {
  value       = azurerm_mssql_server.sql_server.id
  description = "The ID of the Azure SQL Server."
}

output "fully_qualified_domain_name" {
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server."
}

output "identity" {
  value       = azurerm_mssql_server.sql_server.identity
  description = "An identity block containing the Principal ID and Tenant ID for the Service Principal assocated with the Identity of this SQL Server."
}