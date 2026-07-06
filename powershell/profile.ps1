# powershell/profile.ps1
# PowerShell 7 profile for terminal workflow automation
# Install: New-Item -ItemType SymbolicLink -Path $PROFILE -Target (Resolve-Path .\powershell\profile.ps1)

# -------------------------------------------------------
# Dev Session Launcher
# Usage: Start-DevSession [-Project default] [-ProjectRoot C:\path]
# -------------------------------------------------------
function Start-DevSession {
    param(
        [string]$Project = "default",
        [string]$ProjectRoot = "$HOME\projects\$Project"
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
    # --cwd scopes the session to the project root from the start
    wezterm start --cwd $ProjectRoot -- zellij --layout $layoutPath
}

# -------------------------------------------------------
# Aliases
# -------------------------------------------------------
Set-Alias -Name ll -Value Get-ChildItem

# Hardened which: uses a proper param binding (avoids positional arg insecurity)
function which {
    param ([Parameter(Mandatory)][string]$Command)
    try {
        (Get-Command $Command -ErrorAction Stop).Source
    } catch {
        Write-Warning "Command not found: $Command"
    }
}

# -------------------------------------------------------
# Quick navigation
# -------------------------------------------------------
function proj  { Set-Location "$HOME\projects" }
function vault { Set-Location "$HOME\vault-memory" }

# -------------------------------------------------------
# Tool initializations
# -------------------------------------------------------
# Idempotent PATH prepend: only adds mise shims if not already present
$misePath = "$HOME\.local\share\mise\shims"
if ($env:PATH -notlike "*$misePath*") {
    $env:PATH = "$misePath;$env:PATH"
}

# zoxide (smart cd)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# -------------------------------------------------------
# Startup banner - only in interactive shells (not scripts)
# -------------------------------------------------------
if ($Host.Name -eq 'ConsoleHost') {
    Write-Host "Terminal workflow profile loaded" -ForegroundColor Green
}
