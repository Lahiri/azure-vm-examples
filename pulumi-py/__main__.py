from pulumi import Config, export
from pulumi_azure import compute, network

# Import config
config = Config()
vnet = config.require_object("vnet")
vm = config.require_object("vm")
disks = config.require_object("disks")

# Create Data Disk
data_disks = []
for d in range(len(disks)):
    dd = compute.ManagedDisk(
        f"disk{d}",
        name = f"{disks[d]['name']}",
        create_option = 'Empty',
        resource_group_name = vm['resource_group_name'],
        storage_account_type = disks[d]['account_type'],
        disk_size_gb = disks[d]['size_gb'],
        zones = vm['availability_zone'])

    data_disks.append(dd)


# Create Network Interface
azsubnet = network.get_subnet(
    name=vnet['subnet_name'],
    virtual_network_name = vnet['name'],
    resource_group_name = vnet['resource_group_name'])

aznic = network.NetworkInterface(
    'nic',
    name = f"{vm['name']}-nic",
    resource_group_name = vm['resource_group_name'],
    ip_configurations = [{
        "name": "ipconfig1",
        "private_ip_address_allocation": "Dynamic",
        "subnet_id": azsubnet.id}])

# Create VM
osdiskname = f"{vm['name']}-osdisk"
azvm = compute.VirtualMachine(
    'vm',
    name = f"{vm['name']}",
    resource_group_name = vm['resource_group_name'],
    network_interface_ids = [aznic.id],
    vm_size = vm['size'],
    storage_os_disk = {
        "create_option": "FromImage",
        "name": osdiskname,
        "managed_disk_type": vm['os_disk_account_type']
    },
    storage_image_reference = {
        "publisher": "MicrosoftWindowsServer",
        "offer": "WindowsServer",
        "sku": "2016-Datacenter",
        "version": "latest"
    },
    os_profile = {
        "admin_username": vm['local_admin'],
        "admin_password": vm['local_admin_pw'],
        "computer_name": vm['name']
    },
    os_profile_windows_config = {
        "provision_vm_agent": "true",
        "enable_automatic_upgrades": "true"
    },
    zones = vm['availability_zone'],
    license_type = "Windows_Server",
    tags = vm['tags']
    )


# Attach data disk
for i in range(len(data_disks)):
    compute.DataDiskAttachment(
        f"disk{i}-attach",
        caching = "ReadWrite",
        lun = disks[i]['lun'],
        managed_disk_id = data_disks[i].id,
        virtual_machine_id = azvm.id
    )

# Output
export('vm_id', azvm.id)
export('network_interface_id', aznic.id)
export('network_interface_private_ip', aznic.private_ip_address)