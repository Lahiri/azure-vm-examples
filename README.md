# azure-vm-examples

This repository contains code to deploy an Azure VM with a series of different tools. The purpose is to show syntax and verbosity difference and help you decide what tool to adopt in your company.

## Deployment Parameters
The VM deployed in the examples has these parameters:

Parameter | Value
--- | ---
Name | Example-VM
Resource Group | Example-RG
Region | West Europe
Availability Options | Zone 1
Image | Windows Server 2016 Datacenter
VM Size | Standard_DS2_v2
Public IP | No
NSG | No
Hybrid Benefit | Yes
OS Disk | Standard SSD
Data Disks | 1 disk, 128 Gb StandardSSD
VNet | Exaple-Vnet
Subnet | Example-Subnet
Tags | @{OS = 'Windows'; Application = 'Example'}
Admin user | azure_user

N.B: All scripts provided in this repository are designed to deploy a VM that respects the parameters listed above.
All other configurations may or may not vary, as the intent of this example is not to deploy the exact same VM with all scripts, but to provide a solution to the same problem with different tools to allow for a comparison.

## Tool comparison

The following table provides information about the tool used in this repository:

Tool | Developer | Paradigm | Idempotent | Change Preview | Supported Platforms
---- | --------- | -------- | ---------- | -------------- | -------------------
ARM Template | Microsoft | Declarative | Yes | [Yes (preview)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-deploy-what-if) | Platform independent, requires an orchestration tool
Terraform | Hashicorp | Declarative | Yes | [Yes](https://www.terraform.io/docs/commands/plan.html) | Windows, MacOS, Linux, FreeBSD, OpenBSD, Solaris
Azure Powershell | Microsoft | Imperative | No | No | Windows, MacOS, Linux, Web (Cloud shell)
Azure CLI | Microsoft | Imperative | Yes | No | Windows, MacOS, Linux, Web (Cloud shell)