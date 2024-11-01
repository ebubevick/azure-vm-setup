# Azure provider configuration
provider "azurerm" {
  features {}

  # Your Azure subscription ID
  subscription_id = "subscription" /// Add you own subscription
}

# Define the resource group
resource "azurerm_resource_group" "rg" {
  name = "production-rg"

  # Location of the resource group
  location = "uksouth"
}
