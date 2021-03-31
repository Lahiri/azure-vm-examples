param vmname string = 'Example-VM'
param location string = 'westeurope'

@allowed([
  '1'
  '2'
  '3'
])
param zone string = '1'
param size string = 'Standard_DS2_v2'
param storageAccountType string = 'StandardSSD_LRS'
param dataDiskSize int = 128
param vNetName string = 'Example-Vnet'
param subnetName string = 'Example-Subnet'
param nicName string = 'Example-VM-Nic'
param licenseType string = 'Windows_Server'
param tags object = {
  OS: 'Windows'
  Application: 'Example'
}

@secure()
param adminPassword string
param adminUsername string = 'azure_user'

resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  location: location
  name: vmname
  tags: tags
  zones: [
    zone
  ]
  properties: {
    hardwareProfile: {
       vmSize: size
    }
    storageProfile:{
      imageReference:{
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk:{
        osType: 'Windows'
        name: concat(vmname, '.osdisk')
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk:{
          storageAccountType: storageAccountType
        }
      }
      dataDisks: [
        {
          lun: 0
          name: concat(vmname, '-data-disk1')
          createOption: 'Empty'
          caching:'None'
          managedDisk:{
            storageAccountType: storageAccountType
          }
          diskSizeGB: dataDiskSize
        }
      ]
    }
    osProfile:{
      adminUsername: adminUsername
      adminPassword: adminPassword
      computerName: vmname
      windowsConfiguration:{
        provisionVMAgent: true
        enableAutomaticUpdates: true
      }
    }
    networkProfile:{
      networkInterfaces:[
        {
          id: nic.id
        }
      ]
    }
    licenseType: 'Windows_Server'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2019-11-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations:[
      {
        name: 'ipconfig1'
        properties:{
          subnet:{
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vNetName, subnetName)
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings:{
      dnsServers:[]
    }
  }
}

output vm_id string = vm.id
