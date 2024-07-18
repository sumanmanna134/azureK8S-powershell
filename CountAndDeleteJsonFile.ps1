function Count-And-Delete-JsonFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$JsonFilePath
    )

    # Check if the file exists
    if (Test-Path -Path $JsonFilePath) {
        try {
            $jsonContent = Get-Content -Path $JsonFilePath -Raw | ConvertFrom-Json
            $objectCount = $jsonContent.Count

            Write-Host "Total: $objectCount."

            Remove-Item -Path $JsonFilePath -Force

            # Confirm deletion
            if (-not (Test-Path -Path $JsonFilePath)) {
                Write-Host ""
            } else {
                Write-Host "Failed to delete the file $JsonFilePath."
            }
            return $objectCount
        } catch {
            Write-Error "An error occurred: $_"
        }
    } else {
        Write-Host "The file $JsonFilePath does not exist."
    }
}