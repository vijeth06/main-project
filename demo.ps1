$modulePath = Join-Path $PSScriptRoot "libs\external-lib\external.psm1"

if (-not (Test-Path $modulePath)) {
    Write-Error "Submodule module not found at $modulePath"
    Write-Host "Run: git submodule update --init --recursive"
    exit 1
}

Import-Module $modulePath -Force

Write-Host "External Message: $(Get-ExternalMessage)"
Write-Host "External Version: $(Get-ExternalVersion)"
Write-Host "Demo completed successfully."
