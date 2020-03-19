variable "resource_group_name" {
  type = string
  default = "Example-RG"
}
variable "vm_name" {
  type = string
  default = "Example-VM"
}
variable "subnet_name" {
  type = string
  default = "Example-Subnet"
}
variable "vnet_resource_group_name" {
  type = string
  default = "Example-RG"
}
variable "vnet_name" {
  type = string
  default = "Example-Vnet"
}

variable "location" {
  type    = string
  default = "westeurope"
}
variable "data_disks" {
  type = map
  default = {
      data-disk1 = {
          account_type = "StandardSSD_LRS"
          size_gb = "128"
          lun = "0"
      }
  }
}
variable "vm_size" {
  type = string
  default = "Standard_DS2_v2"
}
variable "os_disk_account_type" {
  type = string
  default = "StandardSSD_LRS"
}
variable "local_admin" {
  type = string
  default = "azure_user"
}
variable "local_admin_pw" {
    type = string
}
variable "vm_tags" {
  type = map
  default = {
      OS = "Windows"
      Application = "Example"
  }
}
variable "availability_zone" {
  type = number
  default = 1
}