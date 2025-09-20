local path = os.getenv("HOME") .. "/dotfiles/nvim/"
local prev_path = package.path

package.path = package.path .. ";" .. path .. "?.lua" .. ";" .. path .. "config/?.lua"

if vim.g.vscode then
	require("variables")
	require("mappings")
	require("autocmd")
else
	require("unmapping")
	require("variables")
	require("plugins")
	require("plug-config")
	require("afterplug")
	require("mappings")
	require("autocmd")

	if vim.g.neovide then
		require("neovide")
	end
end

package.path = prev_path
