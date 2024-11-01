# Define a public IP for the load balancer
resource "azurerm_public_ip" "public_lb_ip" {
  name                = "public-lb-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Static allocation for the public IP
  allocation_method = "Static"
  sku               = "Standard"
}

# Define the load balancer
resource "azurerm_lb" "public_lb" {
  name                = "public-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Load balancer SKU
  sku = "Standard"

  # Frontend IP configuration
  frontend_ip_configuration {
    name                 = "public-lb-front"
    public_ip_address_id = azurerm_public_ip.public_lb_ip.id
  }
}

# Define a backend address pool for the load balancer
resource "azurerm_lb_backend_address_pool" "public_backend_pool" {
  name            = "public-backend-pool"
  loadbalancer_id = azurerm_lb.public_lb.id
}

# Define an HTTP health probe
resource "azurerm_lb_probe" "http_probe" {
  name            = "http-health-probe"
  loadbalancer_id = azurerm_lb.public_lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# Define a load balancing rule
resource "azurerm_lb_rule" "lb_rule" {
  name                           = "lb-rule"
  loadbalancer_id                = azurerm_lb.public_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "public-lb-front"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.public_backend_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

# Associate the NIC with the load balancer backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc_1" {
  network_interface_id    = azurerm_network_interface.public_nic_1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.public_backend_pool.id
}

# Un-comment to add association for second NIC
# resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc_2" {
#   network_interface_id        = azurerm_network_interface.public_nic_2.id
#   ip_configuration_name       = "internal"
#   backend_address_pool_id     = azurerm_lb_backend_address_pool.public_backend_pool.id
# }
