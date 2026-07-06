# Zellij Plugins

This directory holds `.wasm` plugin binaries for Zellij.
Binaries are excluded from version control via `.gitignore` (`.wasm` pattern).
Download them manually using the commands below.

## zjstatus — Pinned to v0.19.1

Status bar replacement with session name, mode, and tab display.

### Download (PowerShell)

```powershell
$url = "https://github.com/dj95/zjstatus/releases/download/v0.19.1/zjstatus.wasm"
$dest = "$HOME\.config\zellij\plugins\zjstatus.wasm"

New-Item -ItemType Directory -Force -Path (Split-Path $dest)
Invoke-WebRequest -Uri $url -OutFile $dest

Write-Host "zjstatus downloaded to $dest"
```

### Download (curl / bash / WSL2)

```bash
mkdir -p ~/.config/zellij/plugins
curl -L https://github.com/dj95/zjstatus/releases/download/v0.19.1/zjstatus.wasm \
  -o ~/.config/zellij/plugins/zjstatus.wasm
```

### Verify

```powershell
Get-Item "$HOME\.config\zellij\plugins\zjstatus.wasm"
```

## Updating

To update to a newer version:
1. Change the version tag in the download URL above
2. Update the version comment in `.config/zellij/config.kdl`
3. Re-download the `.wasm` file
