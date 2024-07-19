Param(
    [parameter(Mandatory = $false)]
    [string]$resourceGroupName = "k8s1",
    [parameter(Mandatory = $false)]
    [string]$subscriptionName = "Free Trial",
    [parameter(Mandatory = $false)]
    [string]$resourceGroupLocation = "Central India",
    [parameter(Mandatory = $false)]
    [string]$clusterName = "azure-central-india-cluster",
    [parameter(Mandatory = $false)]
    [int16]$workerNodeCount = 1,
    [parameter(Mandatory = $false)]
    [string]$kubernetesVersion = "1.30",
    [parameter(Mandatory = $false)]
    [string]$acrRegistryName = "ngacrregistry2024",
    [parameter(Mandatory = $false)]
    [string]$osSku = "AzureLinux",
    [parameter(Mandatory = $false)]
    [string]$vmSize = "Standard_DS3_v2",
    [parameter(Mandatory = $false)]
    [string]$nodeOsDiskType = "Ephemeral"


)
. .\CreateResourceGroupIfNotExist.ps1

Write-Host "Setting Azure subscription to $subscriptionName"  -ForegroundColor Yellow
az account set --subscription=$subscriptionName

createRGIfNotExist -resourceGroupName $resourceGroupName -resourceGroupLocation $resourceGroupLocation

. .\createACR.ps1
create-ACR -resourceGroupName $resourceGroupName -resourceGroupLocation $resourceGroupLocation -registryName $acrRegistryName

. .\createMarinerLinuxClusterAKS.ps1
create-mariner-linux-cluster -ResourceGroupName $resourceGroupName `
-ClusterName $clusterName `
-WorkerNodeCount $workerNodeCount `
-KubernetesVersion $kubernetesVersion `
-AcrRegistryName $acrRegistryName `
-VmSize $vmSize `
-OsSku $osSku `
-NodeOsDiskType $nodeOsDiskType

Write-Host "Getting credentials for cluster $clusterName" -ForegroundColor Yellow
az aks get-credentials `
    --resource-group=$resourceGroupName `
    --name=$clusterName `
    --overwrite-existing

Write-Host "Successfully created cluster $clusterName with $workerNodeCount node(s)" -ForegroundColor Green



