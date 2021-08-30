resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resourcename
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnetname
  address_space       = ["172.16.0.0/20"]
  location            = var.location
  resource_group_name = var.resourcename
  tags                = var.tags

}