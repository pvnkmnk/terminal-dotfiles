-- wezterm.lua
-- WezTerm configuration for Windows 11 terminal workflow
-- Auto-launches Zellij on startup

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- GPU acceleration
config.front_end = 'WebGpu'

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 13.0

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

-- Window appearance
config.window_background_opacity = 0.95
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

-- Auto-launch Zellij as the default program
-- Zellij 0.44+ has native Windows support
config.default_prog = { 'zellij', '-l', 'welcome' }

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Scrollback
config.scrollback_lines = 10000

return config
