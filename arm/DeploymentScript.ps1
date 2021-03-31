# This script runs a bicep deployment using the template in the same folder.

$Params = @{
    ResourceGroupName     = "Example-RG"
    TemplateFile          = "./azure.deploy.json"
}

New-AzResourceGroupDeployment @Params