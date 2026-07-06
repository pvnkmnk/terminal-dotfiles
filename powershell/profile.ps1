# powershell/profile.ps1
# PowerShell profile for terminal workflow automation

# -------------------------------------------------------
# Dev Session Launcher
# Usage: Start-DevSession -Project default
# -------------------------------------------------------
function Start-DevSession {
    param(
        [Parameter(Mandatory=$false)]
        [string]$Project = "default"
    )

    $layoutPath = "$HOME\.config\zellij\layouts\$Project.kdl"

    if (-not (Test-Path $layoutPath)) {
        Write-Warning "Layout not found: $layoutPath"
        Write-Host "Available layouts:"
        Get-ChildItem "$HOME\.config\zellij\layouts\" -Filter *.kdl |
            ForEach-Object { Write-Host "  - $($_.BaseName)" }
        return
    }

    Write-Host "Launching dev session: $Project" -ForegroundColor Cyan
    wezterm start -- zellij --layout $layoutPath
}

# -------------------------------------------------------
# Aliases
# -------------------------------------------------------
Set-Alias -Name ll -Value Get-ChildItem
function which { Get-Command $args[0] | Select-Object -ExpandProperty Source }

# -------------------------------------------------------
# Quick navigation
# -------------------------------------------------------
function proj  { Set-Location "$HOME\projects" }
function vault { Set-Location "$HOME\vault-memory" }

# -------------------------------------------------------
# Tool initializations
# -------------------------------------------------------
$env:PATH = "$HOME\.local\share\mise\shims;$env:PATH"

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

Write-Host "Terminal workflow profile loaded" -ForegroundColor Green
