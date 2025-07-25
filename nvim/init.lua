local path = os.getenv("HOME") .. "/.config/nvim/"
package.path = package.path .. ";" .. path .. "?.lua" .. ";" .. path .. "config/?.lua"

if vim.g.vscode then
	require("variables")
	require("mappings")
	require("autocmd")
else
	-- global config: config/global_conf
	-- utils: util
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
