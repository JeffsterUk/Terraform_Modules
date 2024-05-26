output "id" {
  value       = azurerm_mssql_database.sql_database.id
  description = "The ID of the MS SQL Database."
}

output "name" {
  value       = azurerm_mssql_database.sql_database.name
  description = "The Name of the MS SQL Database."
}