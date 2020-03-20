$Credential = Get-Credential -UserName "azure_user"
$VMName = "Example-VM"
$ResourceGroupName = "Example-RG"
$Location = "westeurope"
$VirtualNetworkName = "Example-Vnet"
$SubnetName = "Example-Subnet"
$StorageType = "StandardSSD_LRS"

$ConfigParams = @{
    VMName = $VMName
    VMSize = "Standard_DS2_v2"
    LicenseType = "Windows_Server"
    Zone = 1
}

$VM = New-AzVMConfig @ConfigParams

$VM | Set-AzureRmVMBootDiagnostics -Disable

$VNet = Get-AzVirtualNetwork -Name $VirtualNetworkName
$SubnetId = ($VNet.Subnets | Where-Object {$_.Name -eq $SubnetName}).Id
$NIC = New-AzNetworkInterface -Name $($VMName + '-nic') -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $SubnetId
$null = Add-AzVMNetworkInterface -VM $VM -NetworkInterface $NIC

$null = Set-AzVMOperatingSystem -VM $VM -Windows -Credential $Credential -ComputerName $VMName
$null = Set-AzVMSourceImage -VM $VM -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2016-Datacenter" -Version "latest"
$null = Set-AzVMOSDisk -VM $VM -StorageAccountType $StorageType -CreateOption "FromImage"

$null = Add-AzVMDataDisk -VM $VM -Lun 0 -CreateOption Empty -StorageAccountType $StorageType -Name $($VMName + '-data-disk1') -DiskSizeInGB 128

$DeploymentParams = @{
    ResourceGroupName = $ResourceGroupName
    Location = $Location
    VM = $VM
    Tag = @{
        OS = "Windows"
        Application = "Example"
    }
}

New-AzVm @DeploymentParams