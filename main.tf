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
 resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resourcename
  virtual_network_name = var.vnetname
  address_prefixes     = ["172.16.0.0/24"]
 }

 resource "azurerm_subnet" "ProdSubnet" {
  name                 = "ProdSubnet"
  resource_group_name  = var.resourcename
  virtual_network_name = var.vnetname
  address_prefixes     = ["172.16.1.0/24"]
 }

  resource "azurerm_local_network_gateway" "onpremise" {
  name                = "onpremise"
  location            = var.location
  resource_group_name = var.resourcename
  gateway_address     = "168.62.225.23"
  address_space       = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "AzureGWIP" {
  name                = "AzureGWIP"
  location            = var.location
  resource_group_name = var.resourcename
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "SitetoSite" {
  name                = "SiteToSite"
  location            = var.location
  resource_group_name = var.resourcename
  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.AzureGWIP.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
  }
}
  
resource "azurerm_virtual_network_gateway_connection" "onpremise" {
  name                = "onpremise"
  location            = var.location
  resource_group_name = var.resourcename

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.SitetoSite.id
  local_network_gateway_id   = azurerm_local_network_gateway.onpremise.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}

 