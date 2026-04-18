$externalLibModule = Join-Path $PSScriptRoot "libs\external-lib\external.psm1"
$externalUtilsModule = Join-Path $PSScriptRoot "libs\external-utils\utils.psm1"
$externalConfigModule = Join-Path $PSScriptRoot "libs\external-config\config.psm1"

$requiredModules = @($externalLibModule, $externalUtilsModule, $externalConfigModule)

foreach ($modulePath in $requiredModules) {
    if (-not (Test-Path $modulePath)) {
        Write-Error "Submodule module not found at $modulePath"
        Write-Host "Run: git submodule update --init --recursive"
        exit 1
    }
}

Import-Module $externalLibModule -Force
Import-Module $externalUtilsModule -Force
Import-Module $externalConfigModule -Force

Write-Host "External Message: $(Get-ExternalMessage)"
Write-Host "External Version: $(Get-ExternalVersion)"
Write-Host "External Status: $(Get-ExternalStatus)"
Write-Host "Utils Message: $(Get-UtilsMessage)"
Write-Host "Config Environment: $(Get-ConfigEnvironment)"
Write-Host "Demo completed successfully."
