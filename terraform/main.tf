provider "azurerm" {
  skip_provider_registration = true
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.vnet_name
}

resource "azurerm_managed_disk" "disks" {
  for_each = var.data_disks

  name                 = each.key
  location             = var.location
  create_option        = "Empty"
  resource_group_name  = var.resource_group_name
  storage_account_type = lookup(each.value, "account_type", "Standard_LRS")
  disk_size_gb         = lookup(each.value, "size_gb", "128")
  zones                = [
    var.availability_zone
  ]

}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnet.id
  }

}

resource "azurerm_virtual_machine" "vm" {
  location              = var.location
  name                  = var.vm_name
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  resource_group_name   = var.resource_group_name
  vm_size               = var.vm_size

  storage_os_disk {
    create_option     = "FromImage"
    name              = "${var.vm_name}-osdisk"
    managed_disk_type = var.os_disk_account_type
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_profile {
    admin_username = var.local_admin
    admin_password = var.local_admin_pw
    computer_name  = var.vm_name
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  zones = [
    var.availability_zone
  ]

  license_type = "Windows_Server"

  tags = var.vm_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  for_each = var.data_disks

  caching            = "ReadWrite"
  lun                = lookup(each.value, "lun")
  managed_disk_id    = azurerm_managed_disk.disks[each.key].id
  virtual_machine_id = azurerm_virtual_machine.vm.id
}