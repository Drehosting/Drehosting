variable "resourcename" {
  description = "rsg"
 # default = "test"
  
  
}
variable "location" {
  #default =  "North Europe"
  #validation {
  #  condition = can(regex("^North", var.location))
  #  error_message = "The location should be in North of europe ."
  #}
}
variable "tags" {}

variable "vnetname" {
  
}
