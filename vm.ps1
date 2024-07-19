Param(
    [parameter(Mandatory = $false)]
    [string]$subscription = "Free Trial",
    [parameter(Mandatory = $false)]
    [string]$resourceGroupName = "k8s",
    [parameter(Mandatory = $false)]
    [string]$resourceGrpLocation = "Central India",
    [parameter(Mandatory = $false)]
    [string]$image = "Ubuntu2204",
    [parameter(Mandatory = $false)]
    [string]$vmSize = "Standard_B1s",
    [parameter(Mandatory = $false)]
    [string]$sshKeyPath = "~/.ssh/id_rsa.pub",
    [parameter(Mandatory = $false)]
    [string]$publicIpSku = "standard",
    [parameter(Mandatory = $false)]
    [string]$dnsNamePrefix = "kubeadm-ckad",
    [parameter(Mandatory = $false)]
    [string]$adminUsername = "azuser",
    [parameter(Mandatory = $false)]
    [string]$outputFile = "vm.json"


)
. .\CountAndDeleteJsonFile.ps1
$vmNames = @("kube-master", "kube-worker-1", "kube-worker-2")
$desiredVmCount = $vmNames.Count

Write-Host "Setting Azure Subscription to $subscription" -ForegroundColor Yellow
az account set --subscription=$subscription

$aksRgExists = az group exists --name $resourceGroupName
#Write-Host "$resourceGroupName exists : $aksRgExists"

if($aksRgExists -eq $false){
    #create resource grp

    Write-Host "Creating Resource Group $resourceGroupName in region $resourceGrpLocation" -ForegroundColor Yellow

    az group create `
     --name=$resourceGroupName `
     --location=$resourceGrpLocation `
     --output=jsonc

}else{
    Write-Host "$resourceGroupName Resource Group Successfully found in region $resourceGrpLocation" -ForegroundColor Green
}

Write-Host "Creating Virtual Network" -ForegroundColor Cyan
az network vnet create `
  --name kubevnet `
  --resource-group=$resourceGroupName `
  --location=$resourceGrpLocation `
  --address-prefixes="172.0.0.0/16" `
  --subnet-name="mySubnet" `
  --subnet-prefixes="172.0.0.0/24" `
  --output=jsonc

foreach ($vmName in $vmNames) {
    Write-Host "Creating Virtual machine '$vmName'" -ForegroundColor Blue

    az vm create `
        --name $vmName `
        --resource-group $resourceGroupName `
        --location $resourceGrpLocation `
        --image $image `
        --size $vmSize `
        --data-disk-sizes-gb 10 `
        --admin-username $adminUsername `
        --ssh-key-value $sshKeyPath `
        --public-ip-sku $publicIpSku `
        --public-ip-address-dns-name "${dnsNamePrefix}-${vmName}" `
        --output jsonc
}

az vm list --resource-group $resourceGroupName --output json | Out-File -FilePath $outputFile

$countVm = Count-And-Delete-JsonFile -JsonFilePath $outputFile

if($desiredVmCount -eq $countVm){
    Write-Host "Successfully created VMs" -ForegroundColor Green
}else{
    $failedVm = $desiredVmCount - $countVm
    Write-Error "Failed deploy $failedVm resource"
}
