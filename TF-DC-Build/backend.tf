terraform {

  
  backend "azurerm" {
  storage_account_name = "drehstg001" 
  container_name = "dretf001"
  key = "tf-DHDEMO.tfstate" 
  subscription_id       = "447fdc4c-f9f4-4b14-ab7e-aa40f9745b9d"
  tenant_id             = "e59d8da1-b9cc-4a55-a4cf-f08bc9fbe3ac"
  resource_group_name   = "DRE-RSG-001"  
 }
}
