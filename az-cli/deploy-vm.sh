az vm create \
    --name Example-VM \
    --resource-group Example-RG \
    --location westeurope \
    --zone 1 \
    --image win2016datacenter \
    --size Standard_DS2_v2 \
    --public-ip-address "" \
    --nsg "" \
    --license-type Windows_Server \
    --storage-sku StandardSSD_LRS \
    --data-disk-sizes-gb 128 \
    --vnet-name Example-Vnet \
    --subnet Example-Subnet \
    --admin-username azure_user \
    #--admin-password <secret-string>