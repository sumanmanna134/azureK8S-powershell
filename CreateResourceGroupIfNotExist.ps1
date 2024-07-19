function createRGIfNotExist {
    param (
        [Parameter(Mandatory = $true)]
        [string]$resourceGroupName,
        [Parameter(Mandatory = $true)]
        [string]$resourceGroupLocation
    )
    $aksRgExists = az group exists --name $resourceGroupName
    if($aksRgExists -eq $false){
    #create resource grp

    Write-Host "Creating Resource Group $resourceGroupName in region $resourceGroupLocation" -ForegroundColor Yellow

    az group create `
     --name=$resourceGroupName `
     --location=$resourceGroupLocation `
     --output=jsonc

  Write-Host "Resource Group$resourceGroupName in region $resourceGroupLocation" -ForegroundColor Green

}else{
    Write-Host "$resourceGroupName Resource Group Successfully found in region $resourceGrpLocation" -ForegroundColor Green
}
    
}