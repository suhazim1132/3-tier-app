resource "azurerm_subnet" "subnets" {
  for_each = var.subnet_details
  name                 = "${azurerm_virtual_network.vnet.name}-${each.key}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "subnets_nsg" {
  name                = "subnet-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_associate" {
  depends_on                = [azurerm_network_security_rule.nsg_rule_inbound] 
  for_each = var.subnet_details
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.subnets_nsg.id
}

locals {
  inbound_ports_map = {
    "100" : "80", 
    "110" : "443",
    "120" : "22",
    "130" : "8080",
    "140" : "3306"
  } 
}

resource "azurerm_network_security_rule" "nsg_rule_inbound" {
  for_each = local.inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.subnets_nsg.name
}


