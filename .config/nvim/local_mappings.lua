local util = require("util")

vim.keymap.set("n", "<Leader>gg", function()
	vim.cmd('normal viw"0y')
	util.grep_from_dir_reg("0")
end)

vim.keymap.set("n", "<Leader>cc", function()
	vim.cmd('normal viw"0y')
	util.grep_from_buf_reg("0")
end, { desc = "vim grep words on the current cursor" })

vim.keymap.set("n", "<Leader>gr", function()
	util.grep_from_buf_reg("+")
end, { desc = "vim grep from '+' register" })

vim.keymap.set("n", "<C-t>", "xp", { desc = "transpose current and next character" })
