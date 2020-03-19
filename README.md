# azure-vm-examples
This repository contains code to deploy an Azure VM with a series of different tools. The purpose is to show syntax and verbosity difference and help you decide what tool adopt in your company.

The VM deployed in the examples has these parameters:

Parameter | Value
--- | ---
Name | Example-VM
Resource Group | Example-RG
Region | West Europe
Availability Options | Zone 1
Image | Windows Server 2016 Datacenter
VM Size | Standard_DS3_v2
Public IP | No
NSG | No
Hybrid Benefit | Yes
OS Disk | Standard SSD
Data Disks | 1 disk, 128 Gb StandardSSD
VNet | Exaple-Vnet
Subnet | Example-Subnet
Tags | @{OS = 'Windows'; Application = 'Example'}
