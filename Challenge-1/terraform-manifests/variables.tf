variable "resource_group_name" {
  type = string
  default = "rg-default"  
}

variable "resource_group_location" {
  type = string
  default = "northeurope"  
}

variable "mysql_db_name" {
  type        = string
}

variable "mysql_db_username" {
  type        = string
}

variable "mysql_db_password" {
  type        = string
  sensitive   = true
}

variable "mysql_db_schema" {
  type        = string
}

variable "vnet_name" {
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_details" {
  type = map(string)
  
}

variable "vmss_nsg_inbound_ports" {
  type = list(string)
  default = [22, 80, 443]
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}
variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
}
variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
}
variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
}
