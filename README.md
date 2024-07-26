# Azure Kubernetes Service (AKS) PowerShell Scripts

This repository contains PowerShell scripts for managing and automating tasks related to Azure Kubernetes Service (AKS). These scripts are designed to simplify operations such as cluster management, scaling, and monitoring.

## Features

- **Cluster Management**: Scripts for creating, updating, and deleting AKS clusters.
- **Scaling Operations**: Automate scaling of nodes and pods.
- **Monitoring and Maintenance**: Scripts for checking cluster health and performing maintenance tasks.
- **Configuration Management**: Manage and update cluster configurations efficiently.

## Getting Started

### Prerequisites

- **PowerShell**: Ensure you have PowerShell installed. [Download PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows)
- **Azure CLI**: Install the Azure CLI to interact with Azure resources. [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- **Azure Subscription**: You need an Azure subscription to create and manage AKS clusters.

### Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sumanmanna134/azureK8S-powershell.git
   ```

2. **Navigate to the Scripts Directory**:
   ```bash
   cd azureK8S-powershell
   ```

3. **Authenticate with Azure**:
   Run the following command to log in to your Azure account:
   ```bash
   az login
   ```

### Usage

#### Creating an AKS Cluster

To create a new AKS cluster, use the `Create-AKSCluster.ps1` script:
```powershell
.\Create-AKSCluster.ps1 -ResourceGroupName "myResourceGroup" -ClusterName "myAKSCluster" -Location "EastUS"
```

#### Scaling an AKS Cluster

To scale the number of nodes in an AKS cluster, use the `Scale-AKSCluster.ps1` script:
```powershell
.\Scale-AKSCluster.ps1 -ResourceGroupName "myResourceGroup" -ClusterName "myAKSCluster" -NodeCount 3
```

#### Updating AKS Cluster Configuration

To update the configuration of an AKS cluster, use the `Update-AKSCluster.ps1` script:
```powershell
.\Update-AKSCluster.ps1 -ResourceGroupName "myResourceGroup" -ClusterName "myAKSCluster" -KubernetesVersion "1.20.7"
```

#### Deleting an AKS Cluster

To delete an AKS cluster, use the `Delete-AKSCluster.ps1` script:
```powershell
.\Delete-AKSCluster.ps1 -ResourceGroupName "myResourceGroup" -ClusterName "myAKSCluster"
```

### Directory Structure

- `Create-AKSCluster.ps1` - Script to create a new AKS cluster.
- `Scale-AKSCluster.ps1` - Script to scale the AKS cluster nodes.
- `Update-AKSCluster.ps1` - Script to update the AKS cluster configuration.
- `Delete-AKSCluster.ps1` - Script to delete an AKS cluster.

## Contributing

Contributions are welcome! If you have suggestions or improvements, please submit a pull request with a description of the changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, please open an issue on the GitHub repository or contact me directly.

---

Feel free to customize this template according to your specific needs!
