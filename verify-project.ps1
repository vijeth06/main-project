$ErrorActionPreference = "Stop"

Write-Host "=== Project Verification Started ==="

if (-not (Test-Path ".gitmodules")) {
    throw "Missing .gitmodules file."
}

$gitmodules = Get-Content ".gitmodules" -Raw
if ($gitmodules -notmatch "external-lib\.git") {
    throw "Submodule URL does not point to external-lib GitHub repository."
}

Write-Host "[OK] .gitmodules present and contains external-lib URL"

Write-Host "Checking submodule initialization..."
git submodule update --init --recursive | Out-Host

$status = git submodule status
if (-not $status) {
    throw "Submodule status is empty."
}
Write-Host "[OK] Submodule status:"
Write-Host $status

$modulePath = Join-Path $PSScriptRoot "libs\external-lib\external.psm1"
if (-not (Test-Path $modulePath)) {
    throw "Missing module file in submodule: $modulePath"
}

Import-Module $modulePath -Force

$message = Get-ExternalMessage
$version = Get-ExternalVersion

if (-not $message) {
    throw "Get-ExternalMessage returned empty value."
}
if (-not $version) {
    throw "Get-ExternalVersion returned empty value."
}

Write-Host "[OK] External Message: $message"
Write-Host "[OK] External Version: $version"

Write-Host "=== Project Verification Passed ==="
