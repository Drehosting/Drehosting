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
#variable "oupath" {}
variable "regtoken"  {
   default = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3NkE4Q0I1MTQwNjkyM0E4MkU4QUQ3MUYzQjE4NzEyN0Y2OTRDOTkiLCJ0eXAiOiJKV1QifQ.eyJSZWdpc3RyYXRpb25JZCI6IjhmOTcwOGI5LWFjNTEtNDg2Zi05MTAzLTI5OWM0YWEzM2M2ZSIsIkJyb2tlclVyaSI6Imh0dHBzOi8vcmRicm9rZXItZy1nYi1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1VyaSI6Imh0dHBzOi8vcmRkaWFnbm9zdGljcy1nLWdiLXIwLnd2ZC5taWNyb3NvZnQuY29tLyIsIkVuZHBvaW50UG9vbElkIjoiZWJjNTFhODAtOWE2Zi00Yzg1LWJjMDYtMzQxYjRmMzViYmJjIiwiR2xvYmFsQnJva2VyVXJpIjoiaHR0cHM6Ly9yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJHZW9ncmFwaHkiOiJHQiIsIkdsb2JhbEJyb2tlclJlc291cmNlSWRVcmkiOiJodHRwczovL3JkYnJva2VyLnd2ZC5taWNyb3NvZnQuY29tLyIsIkJyb2tlclJlc291cmNlSWRVcmkiOiJodHRwczovL3JkYnJva2VyLWctZ2ItcjAud3ZkLm1pY3Jvc29mdC5jb20vIiwiRGlhZ25vc3RpY3NSZXNvdXJjZUlkVXJpIjoiaHR0cHM6Ly9yZGRpYWdub3N0aWNzLWctZ2ItcjAud3ZkLm1pY3Jvc29mdC5jb20vIiwibmJmIjoxNjMxMDk2MDkzLCJleHAiOjE2MzI4NzAwMDAsImlzcyI6IlJESW5mcmFUb2tlbk1hbmFnZXIiLCJhdWQiOiJSRG1pIn0.DbGRlfVYDMfcBgIXjzTmfYisSyAK78P0O3w6KtFpLa396mB9XVQOEHDhT2f2_6mbOGN7Xye2-usynogRGSv6M3UFsNpxwszFwrCupfJVIh5am19YRhxzPjHZfEII3LQ2bTfHoe3DRVII_bGvmrcxKgjaQDillkOvGXw7D1vsKe-3_QBfy6tXFf_bPa03GPRIViUDvQVuqaXIZE2uv1Kl1210Hf4PPHymOb4mOXDoYElKWy2dRk7HMk1g0ScKhQFR1OFnjQ1rpKhmpbNd6-Kk5uiJOHWGhDJhIkIwPMC_Op9opmU6axx8rNhRmTEmhc1xV-GnRr-zqr7AT2a9LxnPNA"
}
variable "hostpoolname" {}
variable "artifactslocation" {
  description = "Location of WVD Artifacts" 
  default = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip"
}
variable "wkspacename" {}
variable "hppooled-name" {}
variable "appgrp-name" {}