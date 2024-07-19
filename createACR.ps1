function create-ACR {
    param (
        [Parameter(Mandatory = $true)]
        [string]$resourceGroupName,
        [Parameter(Mandatory = $true)]
        [string]$resourceGroupLocation,
        [Parameter(Mandatory = $true)]
        [string]$registryName

    )
    $acr = az acr show `
            --name $registryName `
            --resource-group $resourceGroupName `
            --query name | ConvertFrom-Json

    $acrExists = $acr.Length -gt 0

    if($acrExists -eq $false){
    #create resource grp

    Write-Host "Creating Azure Registry $registryName under resource group $resourceGroupName in region $resourceGroupLocation" -ForegroundColor Yellow

    try{

    az acr create `
     --name=$registryName `
     --resource-group=$resourceGroupName `
     --location=$resourceGroupLocation `
     --sku Standard `
     --output=jsonc

    }catch{
        Write-Error "Failed to Create ACR: $_"
    }
    

}else{
    Write-Host "$registryName ACR Successfully found in resource group $resourceGroupName" -ForegroundColor Green
}
    
}