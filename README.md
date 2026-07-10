# terminal-dotfiles

Windows 11 terminal workflow dotfiles for a **WezTerm + Zellij + Helix + Television** stack — built for human + AI-assisted coding, multiplexing, fast discovery, and agentic TUI workflows.

Managed with [chezmoi](https://www.chezmoi.io/) for reproducible, single-command machine bootstrapping.

## Stack

| Layer | Tool | Role |
|---|---|---|
| Terminal emulator | WezTerm | GPU-accelerated, Lua-configurable |
| Multiplexer | Zellij 0.44+ | Session/pane/tab control plane (native Windows) |
| Editor | Helix | Terminal-native modal editor |
| Fuzzy launcher | Television | Fast channel-based discovery (fzf replacement) |
| Dotfile manager | chezmoi | Cross-machine dotfile bootstrapping |
| Agentic coding | opencode | AI coding orchestration |

## Install

## Prerequisites

This repo assumes the following are already installed on Windows before running `chezmoi apply`:

- Windows 11 with **winget** available (pre-installed on current Windows 11 builds).
- **WSL2 with your chosen distro already installed** (e.g. `wsl --install -d Ubuntu-24.04`).
  This repo does NOT install WSL itself - `run_once_10-configure-wsl.ps1.tmpl` only verifies
  your distro exists and then bootstraps chezmoi + this repo inside it automatically.
  If the distro is missing, the script will print the exact `wsl --install` command to run
  and stop - just run it once, then re-run `chezmoi apply`.

### Bootstrap

```powershell
chezmoi init --apply https://github.com/pvnkmnk/terminal-dotfiles
```

This single command will:

1. Clone the repo into `~/.local/share/chezmoi`
2. Install Scoop (if not present)
3. Install all packages: WezTerm, Zellij, Helix, Television, mise
4. Apply all dotfiles to the correct locations
5. Fetch plugin binaries (e.g. `zjstatus.wasm`) via `.chezmoiexternal.toml`

## File Structure

```
terminal-dotfiles/
├── .chezmoiscripts/
│   ├── run_once_00-install-scoop.ps1
│   ├── run_once_01-install-packages.ps1
│   └── run_once_02-setup-mise.ps1
├── dot_config/
│   ├── helix/
│   │   └── config.toml
│   ├── television/
│   │   └── cable.toml
│   └── zellij/
│       ├── config.kdl
│       └── plugins/         # zjstatus.wasm fetched via .chezmoiexternal.toml
├── Documents/
│   └── PowerShell/
│       └── Microsoft.PowerShell_profile.ps1
├── dot_wezterm.lua
├── .chezmoi.toml.tmpl
├── .chezmoiexternal.toml
└── .chezmoiignore
```

## Configuration Notes

- **WezTerm**: `~/.wezterm.lua` — GPU-accelerated terminal with custom keybinds and appearance
- **Zellij**: `~/.config/zellij/` — layout and plugin config including zjstatus status bar
- **Helix**: `~/.config/helix/config.toml` — modal editor with LSP support
- **Television**: `~/.config/television/cable.toml` — custom fuzzy search channels
- **PowerShell**: `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` — shell profile with mise activation
