--[[
local status, noice = pcall(require, "noice")

local section = status
		and {
			lualine_x = {
				{
					noice.api.statusline.mode.get,
					cond = noice.api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
			},
		}
	or {}

require("lualine").setup({
	sections = section,
})
--]]

local has_noice, _mod = pcall(require, "noice")

if has_noice then lualine_x = {
	{
		_mod.api.statusline.mode.get,
		cond = _mod.api.statusline.mode.has,
		color = { fg = "#ff9e64" },
	},
} 
else lualine_x = {} end

-- [link to a git post providing a example of showing recording message](https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages)
require("lualine").setup({
	sections = {
		lualine_x = lualine_x,
	},
})
