local wezterm = require "wezterm"

local config = wezterm.config_builder()

-- config.color_scheme = 'Catppuccin Macchiato'

config.audible_bell = 'Disabled'
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.max_fps = 120
-- config.font = wezterm.font('ComicShannsMonoNerdRegular')
config.automatically_reload_config = true
config.font = wezterm.font('Cascadia Mono', {weight = 'Bold', italic = true})
config.font_size = 16
config.enable_wayland = false
config.default_prog = {'/usr/bin/zsh'}
config.disable_default_key_bindings = true
config.keys = {
    {
        key = '=',
        mods = 'CTRL',
        action = wezterm.action.IncreaseFontSize,
    },
    {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action.DecreaseFontSize,
    },
    {
        key = '0',
        mods = 'CTRL',
        action = wezterm.action.ResetFontSize,
    },
}
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.8

return config
