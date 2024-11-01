# Define a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "production-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Define the first public subnet within the virtual network
resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public-subnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define the second public subnet within the virtual network
resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public-subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Define the first private subnet within the virtual network
resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private-subnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.101.0/24"]
}

# Define the second private subnet within the virtual network
resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private-subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.102.0/24"]
}