local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Google Dark (base16)"
-- config.color_scheme = "rose-pine-moon"

config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.max_fps = 60
config.automatically_reload_config = true

-- config.font = wezterm.font('ComicShannsMonoNerdRegular')
-- config.font = wezterm.font("Cascadia Code", { weight = "Bold" })
config.font = wezterm.font("Victor Mono", { weight = "Bold" })
-- config.font = wezterm.font("Scriptina Regular", { weight = "Bold", italic = true })

config.font_size = 16
config.enable_wayland = false
config.default_prog = { "/usr/bin/zsh" }
config.disable_default_key_bindings = true
config.keys = {
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},

	{
		key = "C",
		mods = "CTRL",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},

	{
		key = "V",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},

	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
}

config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
-- config.window_background_opacity = 0.8

return config
