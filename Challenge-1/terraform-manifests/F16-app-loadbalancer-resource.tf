resource "azurerm_lb" "app_lb" {
  name                = "app-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"
  frontend_ip_configuration {
    name = "app-lb-privateip-1"
    subnet_id = azurerm_subnet.subnets[appsubnet].id 
    private_ip_address_allocation = "Static"
    private_ip_address_version = "IPv4"
    private_ip_address = "10.x.x.x"
  }
}
 
resource "azurerm_lb_backend_address_pool" "app_lb_backend_address_pool" {
  name                = "app-backend"
  loadbalancer_id     = azurerm_lb.app_lb.id
}

resource "azurerm_lb_probe" "app_lb_probe" {
  name                = "tcp-probe"
  protocol            = "Tcp"
  port                = 80
  loadbalancer_id     = azurerm_lb.app_lb.id
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_lb_rule" "app_lb_rule_app1" {
  name                           = "app-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "app-lb-privateip-1"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.app_lb_backend_address_pool.id 
  probe_id                       = azurerm_lb_probe.app_lb_probe.id
  loadbalancer_id                = azurerm_lb.app_lb.id
  resource_group_name            = azurerm_resource_group.rg.name
}

