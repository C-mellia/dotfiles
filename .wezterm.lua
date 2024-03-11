local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'

config.audible_bell = 'Disabled'
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.max_fps = 120
-- config.font = wezterm.font('ComicShannsMonoNerdRegular')
config.automatically_reload_config = true
config.font = wezterm.font('Cascadia Mono', {weight = 'Bold', italic = true})
config.font_size = 16
config.enable_wayland = false

return config
