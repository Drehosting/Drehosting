variable "resourcename" {}
variable "location" {}
variable "tags" {}
variable "vnetname" {}
variable "prodsubnet" {}
variable "keyvault" {}
variable "tenantid" {}
variable "vmsize" {} 
variable "admin_username" {}
variable "avdsize" {}
variable "avd_name"{}
variable "vmcount" {}
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}
variable "domain" {}
variable "domainuser" {}
variable "oupath" {}
variable "regtoken"  {}
variable "hostpoolname" {}
variable "artifactslocation" {
  description = "Location of WVD Artifacts" 
  default = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip"
}

#hostpoolvars
variable "wkspacename" {}
variable "hppooled-name" {}
variable "appgrp-name" {}
