#Requires -Version 7.0
# install.ps1
# Automated symlink installer for terminal-dotfiles
# Run from the repo root: .\install.ps1
# Requires PowerShell 7+ and administrator privileges for symlinks on Windows

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function New-Symlink {
    param(
        [string]$Source,  # Repo-relative source path
        [string]$Target   # Absolute destination path
    )

    $resolvedSource = Join-Path $PSScriptRoot $Source

    if (-not (Test-Path $resolvedSource)) {
        Write-Warning "Source not found, skipping: $resolvedSource"
        return
    }

    # Create parent directory if needed
    $parentDir = Split-Path $Target -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
        Write-Host "  Created directory: $parentDir" -ForegroundColor DarkGray
    }

    # Remove existing file/link
    if (Test-Path $Target) {
        Remove-Item $Target -Force
    }

    New-Item -ItemType SymbolicLink -Path $Target -Target $resolvedSource | Out-Null
    Write-Host "  Linked: $Target" -ForegroundColor Green
    Write-Host "     --> $resolvedSource" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "terminal-dotfiles installer" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------
# File mapping: Source (repo-relative) -> Target (absolute)
# -------------------------------------------------------
$links = @(
    @{ Source = ".config\wezterm\wezterm.lua";      Target = "$HOME\.config\wezterm\wezterm.lua" },
    @{ Source = ".config\zellij\config.kdl";         Target = "$HOME\.config\zellij\config.kdl" },
    @{ Source = ".config\zellij\layouts\default.kdl"; Target = "$HOME\.config\zellij\layouts\default.kdl" },
    @{ Source = ".config\helix\config.toml";          Target = "$HOME\.config\helix\config.toml" },
    @{ Source = ".config\television\cable.toml";       Target = "$HOME\.config\television\cable.toml" },
    @{ Source = "powershell\profile.ps1";             Target = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
)

foreach ($link in $links) {
    New-Symlink -Source $link.Source -Target $link.Target
}

Write-Host ""
Write-Host "Installation complete." -ForegroundColor Cyan
Write-Host "Note: zjstatus.wasm must be downloaded separately."
Write-Host "See: .config\zellij\plugins\README.md"
Write-Host ""
