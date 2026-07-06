-- .config/wezterm/wezterm.lua
-- WezTerm configuration for Windows 11 terminal workflow
-- XDG path: ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- GPU acceleration
-- Preferred; fallback to OpenGL: config.front_end = 'OpenGL'
config.front_end = 'WebGpu'

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 13.0

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

-- Window appearance
config.window_background_opacity = 0.95
-- text_background_opacity must be set when window_background_opacity < 1.0
-- to prevent bleed-through on text rendering
config.text_background_opacity = 1.0
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

-- Auto-launch Zellij unless WEZTERM_NO_ZELLIJ is set
-- Use: $env:WEZTERM_NO_ZELLIJ=1 to start a plain shell
if os.getenv('WEZTERM_NO_ZELLIJ') == nil then
  config.default_prog = { 'zellij', '-l', 'welcome' }
end

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Scrollback
config.scrollback_lines = 10000

return config
