resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.wkspacename
  location            = var.location
  resource_group_name = var.resourcename

  friendly_name = var.wkspacename
  description   = "Test Workspace Deployed using Terraform"
}

resource "azurerm_virtual_desktop_host_pool" "wvdhppooled" {
  name                = var.hppooled-name
  location            = var.location
  resource_group_name = var.resourcename

  type               = "Pooled"
  load_balancer_type = "DepthFirst"
  lifecycle {
    ignore_changes = [
      registration_info,
    ]
}
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = var.appgrp-name
  location            = var.location
  resource_group_name = var.resourcename

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.wvdhppooled.id
  friendly_name = var.appgrp-name
  description   = "Test App Group"
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspacedesktopapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}