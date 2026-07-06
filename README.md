# terminal-dotfiles

Windows 11 terminal workflow dotfiles for a **WezTerm + Zellij + Helix + Television** stack — built for human + AI-assisted coding, multiplexing, fast discovery, and agentic TUI workflows.

## Stack

| Layer | Tool | Role |
|---|---|---|
| Terminal emulator | WezTerm | GPU-accelerated, Lua-configurable |
| Multiplexer | Zellij 0.44+ | Session/pane/tab control plane (native Windows) |
| Editor | Helix | Terminal-native modal editor |
| Fuzzy launcher | Television | Fast channel-based discovery (fzf replacement) |
| Dotfile manager | chezmoi | Cross-machine dotfile bootstrapping |
| Agentic coding | opencode | AI coding orchestration |

## File Structure

```
terminal-dotfiles/
├── wezterm.lua                          # Terminal config + auto-launch Zellij
├── .config/
│   ├── zellij/
│   │   ├── config.kdl                   # Zellij core config + zjstatus plugin
│   │   └── layouts/
│   │       └── default.kdl              # Default dev workspace layout
│   ├── helix/
│   │   └── config.toml                  # Helix editor settings
│   └── television/
│       └── cable.toml                   # Custom fuzzy discovery channels
└── powershell/
    └── profile.ps1                      # Start-DevSession workspace launcher
```

## Quick Start

### Bootstrap with chezmoi

```powershell
chezmoi init --apply https://github.com/pvnkmnk/terminal-dotfiles.git
```

### Manual setup

```powershell
git clone https://github.com/pvnkmnk/terminal-dotfiles.git
# Copy files to their respective locations (see structure above)
```

### Launch a dev session

```powershell
# Load the profile first
. $PROFILE

# Launch a project workspace
Start-DevSession -Project default
```

## Config Highlights

### WezTerm → auto-launches Zellij
- `default_prog` set to `zellij -l welcome` so every new terminal window drops straight into a Zellij session.

### Zellij layout
- Vertical split: **Helix** on the left, **lazygit** + **opencode** + log tail on the right.
- `zjstatus` plugin for a clean status bar showing mode + session name + tabs.

### Television channels
- `git-repos`: fuzzy-find all project directories under `~/projects`
- `docker-containers`: live list of running Docker container names

### Helix
- Gruvbox theme, relative line numbers, file picker shows hidden files.

### PowerShell
- `Start-DevSession` function: takes a `$Project` param and launches `wezterm start -- zellij --layout <layout>.kdl`

## Requirements

- Windows 11
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Zellij](https://zellij.dev/) >= 0.44.0
- [Helix](https://helix-editor.com/)
- [Television](https://github.com/alexpasmantier/television)
- [chezmoi](https://www.chezmoi.io/) (optional, for dotfile management)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [opencode](https://opencode.ai/)

## System

Built on: Windows 11 Home · AMD Ryzen 5 5600 · RTX 3060 8GB · PowerShell 7
