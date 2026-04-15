$ErrorActionPreference = "Stop"

Write-Host "=== Submodule Update Workflow Started ==="

Write-Host "Fetching latest commits for submodule..."
git submodule update --remote --merge | Out-Host

Write-Host "Staging updated submodule pointer..."
git add libs/external-lib

if (-not (git diff --cached --quiet)) {
    git commit -m "Update submodule pointer to latest external-lib"
    Write-Host "[OK] Submodule pointer commit created."
} else {
    Write-Host "[OK] No submodule pointer change detected."
}

Write-Host "Synchronizing submodule URLs..."
git submodule sync --recursive | Out-Host

Write-Host "=== Submodule Update Workflow Completed ==="
