resource "azurerm_mssql_server" "mysql_server" {
  name                              = var.mysql_db_name
  location                          = azurerm_resource_group.rg.location
  resource_group_name               = azurerm_resource_group.rg.name
  administrator_login               = var.mysql_db_username
  administrator_login_password      = var.mysql_db_password
  version                           = "12.0"
  minimum_tls_version               = "1.2"
}

resource "azurerm_mysql_database" "appdb" {
  name                = var.mysql_db_schema
  server_id           = azurerm_mssql_server.mysql_server.id
  max_size_gb         = 5
  sku_name            = "GP_S_Gen5_2"
  zone_redundant      = true
}

resource "azurerm_mssql_virtual_network_rule" "mysql_virtual_network_rule" {
  name                = "mysql-vnet-rule"
  server_id           = azurerm_mssql_server.mysql_server.id
  subnet_id           = azurerm_subnet.subnets[dbsubnet].id  
}
