#CreateNics
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}${count.index + 1}"
  location            = "${var.location}"
  resource_group_name = "${var.res_group}"
  count               = "${var.vm_count}"

  ip_configuration {
    name                                    = "webipconfig${count.index}"
    subnet_id                               = "${var.subnet_id}"
    private_ip_address_allocation           = "Dynamic"
    }
}

#Create Session Host ()
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}${count.index + 1}"
  location              = "${var.location}"
  resource_group_name   = "${var.res_group}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  count                 = "${var.vm_count}"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "${var.vm_name}${count.index + 1}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.vm_name}${count.index + 1}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}

#DomainJoin
resource "azurerm_virtual_machine_extension" "domainjoinext" {
  name                 = "join-domain"
  virtual_machine_id   = element(azurerm_virtual_machine.vm.*.id, count.index)
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.0"
  depends_on           = ["azurerm_virtual_machine.vm"]
  count                = "${var.vm_count}"

  settings = <<SETTINGS
    {
        "Name": "${var.domain}",
        "OUPath": "${var.oupath}",
        "User": "${var.domainuser}",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "${var.domainpassword}"
    }
PROTECTED_SETTINGS
}

#AVD Agent Config
resource "azurerm_virtual_machine_extension" "registersessionhost" {
  name                 = "registersessionhost"
  virtual_machine_id   = element(azurerm_virtual_machine.vm.*.id, count.index)
  publisher            = "Microsoft.Powershell"
  depends_on           = ["azurerm_virtual_machine_extension.domainjoinext"]
  count                = "${var.vm_count}"
  type = "DSC"
  type_handler_version = "2.73"
  auto_upgrade_minor_version = true
  settings = <<SETTINGS
    {
        "ModulesUrl": "${var.artifactslocation}",
        "ConfigurationFunction" : "Configuration.ps1\\AddSessionHost",
        "Properties": {
            "hostPoolName": "${var.hostpoolname}",
            "registrationInfoToken": "${var.regtoken}"
        }
    }
SETTINGS
}