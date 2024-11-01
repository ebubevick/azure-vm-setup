# Create the Bastion Virtual Network (VNet) in the same Resource Group as the Production VNet but in a different region (UK South)
resource "azurerm_virtual_network" "bastion_vnet" {
  name                = "bastion-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = "centralus" # Bastion VNet in a different region
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a subnet for the Bastion Host within the Bastion VNet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.bastion_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# VNet Peering from Bastion VNet to Production VNet
resource "azurerm_virtual_network_peering" "bastion_to_production" {
  name                      = "bastion-to-production"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.bastion_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# VNet Peering from Production VNet to Bastion VNet
resource "azurerm_virtual_network_peering" "production_to_bastion" {
  name                      = "production-to-bastion"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.bastion_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# Create a Public IP for the Bastion Host
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion-public-ip"
  location            = azurerm_virtual_network.bastion_vnet.location # Use the location of the Bastion VNet
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}


# Deploy the Bastion Host in the Bastion VNet
resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = azurerm_virtual_network.bastion_vnet.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}
