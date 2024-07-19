Write-Host "Installing RabbitMQ on cluster" -ForegroundColor Cyan
& ((Split-Path $MyInvocation.InvocationName) + "\deployRabbitMQ.ps1")