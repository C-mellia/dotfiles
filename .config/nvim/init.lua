local config_name = "nvim"
local home = os.getenv("HOME")
local path = home .. "/dotfiles/" .. config_name
local local_path = home .. "/.config/nvim"

package.path = package.path .. ";" .. path .. "/?.lua"
package.path = package.path .. ";" .. local_path .. "/?.lua"
package.path = package.path .. ";" .. local_path .. "/config/?.lua"

-- base config
require("base")

-- local configs
if not vim.g.vscode then
	require("local_mappings")
	require("local_plugins")
	require("local_afterplug")
end
