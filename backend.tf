terraform {
  backend "azurerm" {
  storage_account_name = "drehstg001" 
  container_name = "dretf001"
  key = "tf-DHMain.tfstate" 
  access_key           = "SS/r2/SJLNAx7kcFuDm2W4aG0GimNe3uFpS6RDosCXGGwFzERG3Gh6soWvjZ7CAgcoXOQ+tFbSXCOm7IiCO+Xw=="
  }
}