# Examples of Infrastructure as Code tools for Microsoft Azure

This repository contains code to deploy an Azure VM with a series of different automation tools. The purpose is to show syntax and verbosity difference to help you decide what tool to adopt in your company.

**Currently included:**
- ARM Template
- Bicep
- Terraform
- Pulumi (Python)
- Azure Powershell
- Azure CLI

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
VNet | Example-Vnet
Subnet | Example-Subnet
Tags | @{OS = 'Windows'; Application = 'Example'}
Admin user | azure_user

N.B: All scripts provided in this repository are designed to deploy a VM that respects the parameters listed above.
All other configurations may or may not vary, as the intent of this example is not to deploy the exact same VM with all scripts, but to provide a solution to the same problem with different tools to allow for a comparison.

## Tool comparison

The following table provides information about the tool used in this repository:

Tool | Developer | Language | Paradigm | Idempotent | Change Preview | Supported Platforms
---- | --------- | -------- | -------- | ---------- | -------------- | -------------------
**ARM Template** | Microsoft | JSON | Declarative | Yes | Yes | Platform independent
**Bicep** | Microsoft | Bicep | Declarative | Yes | Yes | Platform independent
**Terraform** | HashiCorp | HCL | Declarative | Yes | Yes | Windows, MacOS, Linux, FreeBSD, OpenBSD, Solaris
**Pulumi** | Pulumi | Python, JavaScript, TypeScript, Go, .NET languages | Declarative | Yes | Yes | Windows, MacOS, Linux
**Azure Powershell** | Microsoft | Powershell | Imperative | No | No | Windows, MacOS, Linux, Web (Cloud shell)
**Azure CLI** | Microsoft | Azure CLI | Imperative | Yes | Yes | Windows, MacOS, Linux, Web (Cloud shell)
