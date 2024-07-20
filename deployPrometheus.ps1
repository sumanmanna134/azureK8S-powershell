Write-Host "deploying Prometheus using helm" -ForegroundColor Yellow
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm upgrade --install prometheus `
prometheus-community/kube-prometheus-stack `
--wait
