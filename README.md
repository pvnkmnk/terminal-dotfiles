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

### Prerequisites

- Windows 11
- PowerShell 7+
- [chezmoi](https://www.chezmoi.io/install/) installed

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
