# run_once: Configure mise tool version manager
if (Get-Command mise -ErrorAction SilentlyContinue) {
    Write-Host "Activating mise..."
    mise trust
    mise install
} else {
    Write-Host "mise not found. Install it first via Scoop."
    exit 1
}
