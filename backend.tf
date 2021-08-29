terraform {


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  use_msi = true

  backend "azurerm" {
  storage_account_name = "drehstg001" 
  container_name = "dretf001"
  key = "tf-DHMain.tfstate" 
 }
}
}