# This script runs an ARM deployment using the template and the parameter files in the same folder.

$Params = @{
    ResourceGroupName     = "Example-RG"
    TemplateFile          = "./main.bicep"
    TemplateParameterFile = "./azure.deploy.parameters.json"
}

New-AzResourceGroupDeployment @Params