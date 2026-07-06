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
├── .config/
│   ├── wezterm/
│   │   └── wezterm.lua                  # Terminal config + WEZTERM_NO_ZELLIJ escape hatch
│   ├── zellij/
│   │   ├── config.kdl                   # Zellij core config + zjstatus plugin
│   │   ├── layouts/
│   │   │   └── default.kdl              # Default dev workspace layout
│   │   └── plugins/
│   │       └── README.md                # zjstatus download instructions (pinned v0.19.1)
│   ├── helix/
│   │   └── config.toml                  # Helix editor settings (Catppuccin Mocha)
│   └── television/
│       └── cable.toml                   # Custom fuzzy discovery channels
├── powershell/
│   └── profile.ps1                      # Start-DevSession launcher + aliases
├── .chezmoi.yaml                        # chezmoi source mapping
├── .gitignore
├── install.ps1                          # Automated symlink installer
└── README.md
```

## File Destination Mapping

| Repo file | Destination |
|---|---|
| `.config/wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `.config/zellij/config.kdl` | `~/.config/zellij/config.kdl` |
| `.config/zellij/layouts/default.kdl` | `~/.config/zellij/layouts/default.kdl` |
| `.config/helix/config.toml` | `~/.config/helix/config.toml` |
| `.config/television/cable.toml` | `~/.config/television/cable.toml` |
| `powershell/profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` |

## Installation

### Option A — Automated symlinks (recommended)

```powershell
# Clone the repo
git clone https://github.com/pvnkmnk/terminal-dotfiles.git
cd terminal-dotfiles

# Run the installer (requires PowerShell 7+ and admin for symlinks)
.\install.ps1
```

### Option B — chezmoi

```powershell
chezmoi init --apply https://github.com/pvnkmnk/terminal-dotfiles.git
```

### After installing

1. **Download zjstatus** — see `.config/zellij/plugins/README.md` for versioned download commands
2. **Load PowerShell profile**: `. $PROFILE`
3. **Launch a dev session**: `Start-DevSession -Project default`

### Escape hatch

To open WezTerm without auto-launching Zellij:

```powershell
$env:WEZTERM_NO_ZELLIJ = 1
wezterm
```

## Config Highlights

### WezTerm
- Configured at `~/.config/wezterm/wezterm.lua` (XDG-compliant path)
- `WEZTERM_NO_ZELLIJ=1` skips auto-launch for a plain shell
- `text_background_opacity = 1.0` prevents bleed-through with transparency
- WebGpu front-end; fallback comment included for OpenGL

### Zellij
- Keybind reference block at the top of `config.kdl`
- `zjstatus` pinned to **v0.19.1** — download separately (`.wasm` excluded from git)
- Default layout: Helix (60%) | lazygit + opencode + log tail
- Panes use `cwd` for project-scoped startup

### Television
- `env-vars` channel filters secrets (KEY/TOKEN/SECRET/PASSWORD/etc.)
- `docker-containers` preview scoped via `jq` (not raw `docker inspect`)
- `lazydocker`, `vault-memory`, and `mise-tools` channels included

### Helix
- Theme: **Catppuccin Mocha** (aligned with WezTerm + Zellij)
- `g+f` = file picker, `g+b` = buffer picker (avoids shadowing motion keys)

### PowerShell
- `Start-DevSession -Project <name> [-ProjectRoot <path>]` — launches WezTerm with `--cwd`
- `which` uses `param([Parameter(Mandatory)])` binding
- PATH prepend is idempotent (checks before adding mise shims)
- Banner gated on `$Host.Name -eq 'ConsoleHost'` (safe in scripts)

## Requirements

- Windows 11
- PowerShell 7+
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Zellij](https://zellij.dev/) >= 0.44.0 (native Windows)
- [Helix](https://helix-editor.com/)
- [Television](https://github.com/alexpasmantier/television)
- [chezmoi](https://www.chezmoi.io/) (optional)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [opencode](https://opencode.ai/)
- [jq](https://jqlang.github.io/jq/) (for docker preview in television)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (optional, for smart cd)
- [mise](https://mise.jdx.dev/) (optional, for tool version management)

## System

Built on: Windows 11 Home · AMD Ryzen 5 5600 · RTX 3060 8GB · PowerShell 7
