# Define a public IP for the NAT gateway
resource "azurerm_public_ip" "private_nat_ip" {
  name                = "private-nat-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Static allocation for the public IP
  allocation_method = "Static"
  sku               = "Standard"
}

# Define the NAT gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "private-nat-gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # NAT gateway SKU
  sku_name = "Standard"
}

# Associate the public IP with the NAT gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.private_nat_ip.id
}

# Associate the NAT gateway with private subnets
resource "azurerm_subnet_nat_gateway_association" "private_subnet_1_nat" {
  subnet_id      = azurerm_subnet.private_subnet_1.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "private_subnet_2_nat" {
  subnet_id      = azurerm_subnet.private_subnet_2.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
