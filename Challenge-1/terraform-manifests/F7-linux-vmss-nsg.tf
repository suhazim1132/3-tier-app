resource "azurerm_network_security_group" "vmss_nsg" {
  name                = "vmss-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = toset(var.vmss_nsg_inbound_ports)
    content {
      name                       = "inbound-rule-${each.key}"
      description                = "Inbound Rule ${each.key}"    
      priority                   = sum([100, each.key])
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = each.key
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

