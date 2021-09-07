variable "resource_group" {
  description = "The name of the resource group in which to create the Azure resources"
  default = "myResourceGroup"
}

variable "location" {
  description = "The location/region where the session hosts are created"
  default = "East US"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default = "Standard_B2s"
}

variable "image_publisher" {
  description = "Image Publisher"
  default = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "Image Offer"
  default = "WindowsServer"
}

variable "image_sku" {
  description = "Image SKU"
  default = "2016-Datacenter"
}

variable "image_version" {
  description = "Image Version"
  default = "latest"
}

variable "admin_username" {
  description = "Local Admin Username"
  default = "azureadmin"
}

variable "admin_password" {
  description = "Admin Password"
  default = "P@55W0rD!!"
}

variable "subnet_id" {
  description = "Azure Subnet ID"
  default = "/subscriptions/xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx/resourceGroups/wvd-rg/providers/Microsoft.Network/virtualNetworks/wvd-vnet/subnets/wvd"
}

variable "vm_name" {
  description = "Virtual Machine Name"
  default = "avd-vm-host-"
}

variable "vm_count" {
  description = "Number of Session Host VMs to create" 
  default = "5"
}

variable "domain" {
  description = "Domain to join" 
  default = "avd.local"
}

variable "domainuser" {
  description = "Domain Join User Name" 
  default = "admin@avd.local"
}

variable "oupath" {
  description = "OU Path"
  default = "OU=AVD,DC=avd,DC=local"
}

variable "domainpassword" {
  description = "Domain User Password" 
  default = "password"
}

variable "regtoken" {
  description = "Host Pool Registration Token" 
  default = "registration token generated by hostpool goes here"
}

variable "hostpoolname" {
  description = "Host Pool Name to Register Session Hosts" 
  default = "avd-host-pool"
  }

variable "artifactslocation" {
  description = "Location of WVD Artifacts" 
  default = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip"
}
