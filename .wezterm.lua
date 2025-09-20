local wezterm = require("wezterm")
local path = os.getenv("HOME") .. "/dotfiles/wezterm/"
package.path = package.path .. ";" .. path .. "?.lua" .. ";"
local ok, config = pcall(require, "config")

if not ok then
	os.execute("notify-send 'wezterm' 'Failed to load config.lua'")
	config = wezterm.config_builder()
else
	-- Custom configurations
	-- config.font = wezterm.font("<Your Font Name>", {})
	-- config.font_size = 24
	-- config.color_scheme = "rose-pine"
end

return config
