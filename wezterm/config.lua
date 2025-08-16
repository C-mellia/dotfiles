local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.max_fps = 60
config.automatically_reload_config = true

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

return config
