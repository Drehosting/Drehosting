#Resource Group
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resourcename
  location = var.location
  tags     = var.tags
}

#VNEt
resource "azurerm_virtual_network" "virtualnetwork" {
  depends_on          = [azurerm_resource_group.resourcegroup]
  name                = var.vnetname
  address_space       = ["172.16.0.0/20"]
  dns_servers         = ["172.16.0.4", "8.8.8.8"]
  location            = var.location
  resource_group_name = var.resourcename
  tags                = var.tags

}

 resource "azurerm_subnet" "prodsubnet" {
  depends_on          = [azurerm_virtual_network.virtualnetwork]
  name                 = var.prodsubnet
  resource_group_name  = var.resourcename
  virtual_network_name = var.vnetname
  address_prefixes     = ["172.16.0.0/24"]
 }

#KevVault
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  depends_on                  = [azurerm_resource_group.resourcegroup]
  name                        = var.keyvault             
  location                    = var.location
  resource_group_name         = var.resourcename
  tenant_id                   = var.tenantid
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
    access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]

    storage_permissions = [
      "get",
    ]
  }
  tags = var.tags
}   
#Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 16
  special = true
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = random_password.vmpassword.result
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on   = [azurerm_key_vault.keyvault]
}


#Public IPs
resource "azurerm_public_ip" "vm01-pip" {
  depends_on                  = [azurerm_resource_group.resourcegroup]
  name                = "vm01-pip"
  resource_group_name = var.resourcename
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
#Create VM
#Create NICs and associate the Public IPs
resource "azurerm_network_interface" "vm01nic01" {
  depends_on          = [azurerm_public_ip.vm01-pip]
  name                = "vm01nic01"
  location            = var.location
  resource_group_name = var.resourcename


  ip_configuration {
    name                          = "vm01-ipconfig"
    subnet_id                     = azurerm_subnet.prodsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm01-pip.id
  }

  tags = var.tags
}
#RDP Access Rules for Lab
#Get Client IP Address for NSG
data "http" "clientip" {
  url = "https://ipv4.icanhazip.com/"
}

#NSG
resource "azurerm_network_security_group" "vm01-nsg" {
  name                = "vm01-nsg"
  location            = var.location
  resource_group_name = var.resourcename

  security_rule {
    name                       = "RDP-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${chomp(data.http.clientip.body)}/32"
    destination_address_prefix = "*"
  }
  tags = var.tags
  
}

# Setup NSG association Subnet
resource "azurerm_subnet_network_security_group_association" "region1-vnet1-snet1" {
  subnet_id                 = azurerm_subnet.prodsubnet.id
  network_security_group_id = azurerm_network_security_group.vm01-nsg.id
}

resource "azurerm_windows_virtual_machine" "vm01" {
  name                = "vm01"
  depends_on          = [azurerm_key_vault.keyvault]
  resource_group_name = var.resourcename
  location            = var.location
  size                = var.vmsize
  admin_username      = var.admin_username
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [azurerm_network_interface.vm01nic01.id,]

  tags = var.tags

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

#Run setup scripts on dc01 virtual machines
#Region1
resource "azurerm_virtual_machine_extension" "dc01-basesetup" {
  name                 = "dc01-basesetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm01.id
  depends_on           = [azurerm_windows_virtual_machine.vm01]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./baselab_DCSetup1.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://drehstg001.blob.core.windows.net/dretf001/baselab_DCSetup1.ps1?sp=r&st=2021-09-07T15:09:57Z&se=2022-08-30T23:09:57Z&spr=https&sv=2020-08-04&sr=c&sig=thF9FntFLfTXugSdYH%2Bs%2F9Udl%2BXdLw9G4Uj%2FD8Q%2FWuY%3D"
        ]
    }
  SETTINGS
}