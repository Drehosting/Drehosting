resource "azurerm_storage_account" "fsstorage" {
  name                     = var.storageaccountname
  resource_group_name      = var.resourcename
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "fshare1" {
  name                 = var.filesharename
  storage_account_name = var.storageaccountname
  quota                = 50
  depends_on           = [azurerm_storage_account.fsstorage]
}