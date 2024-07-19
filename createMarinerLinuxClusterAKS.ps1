function create-mariner-linux-cluster {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory = $true)]
        [string]$ClusterName,
        [Parameter(Mandatory = $true)]
        [string]$WorkerNodeCount,
        [Parameter(Mandatory = $true)]
        [string]$KubernetesVersion,
        [Parameter(Mandatory = $true)]
        [string]$AcrRegistryName,
        [Parameter(Mandatory = $true)]
        [string]$VmSize,
        [Parameter(Mandatory = $true)]
        [string]$OsSku,
        [Parameter(Mandatory = $true)]
        [string]$NodeOsDiskType
    )

    $aks = az aks show `
            --name $ClusterName `
            --resource-group $resourceGroupName `
            --query name | ConvertFrom-Json

    $aksCLusterExists = $aks.Length -gt 0

    if ($aksCLusterExists -eq $false) {
    # Create AKS cluster
    Write-Host "Creating AKS cluster $ClusterName with resource group $ResourceGroupName -ForegroundColor Yellow"
    az aks create `
        --resource-group $ResourceGroupName `
        --name=$ClusterName `
        --node-count $WorkerNodeCount `
        --enable-managed-identity `
        --output jsonc `
        --kubernetes-version $KubernetesVersion `
        --attach-acr $AcrRegistryName `
        --node-vm-size $VmSize `
        --os-sku $OsSku `
        --node-osdisk-type $NodeOsDiskType
    
    if (!$?) {
        Write-Error "Error creating ASK cluster" -ErrorAction Stop
    }

}
             

    
}