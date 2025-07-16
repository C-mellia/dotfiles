local path = os.getenv("HOME") .. "/dotfiles/wezterm/"
package.path = package.path .. ";" .. path .. "?.lua" .. ";"
local ok, _config = pcall(require, "config")

if not ok then
	local wezterm = require("wezterm")
	_config = wezterm.config_builder()
	return _config
end

_config.font_size = 26
_config.color_scheme = "rose-pine-moon"

return _config
