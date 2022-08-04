resource_group_name = "Three-tier-app-rg"
resource_group_location = "northeurope"
vnet_name = "Three-tier-app-vnet"
vnet_address_space = ["10.1.0.0/16"]

subnet_details = {
    websubnet = "10.1.1.0/24"
    appsubnet = "10.1.11.0/24"
    dbsubnet  = "10.1.21.0/24"
}

vmss_nsg_inbound_ports = [22, 80, 443]

admin_username = "suhail"

storage_account_name              = "staticwebsite"
storage_account_tier              = "Standard"
storage_account_replication_type  = "LRS"
storage_account_kind              = "StorageV2"

mysql_db_name = "appvmssmysql"
mysql_db_username = "suhail"
mysql_db_schema = "appvmssdb"