local util = require("util")
-- local oil = require("oil.actions")

vim.keymap.set("n", "<C-j>", "<cmd>:cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>:cprev<CR>")

vim.keymap.set("n", "<leader>xc", "<cmd>:wa | qa!<CR>", { desc = "save quit" })
vim.keymap.set(
	"n",
	"<Leader>`",
	"<cmd>:e " .. os.getenv("HOME") .. "/.config/nvim/init.lua<CR>",
	{ desc = "edit nvim config file" }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move line(s) up" })

vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, { desc = "toggle undotree" })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "toggle fugitive" })

-- avoid fat finger
vim.keymap.set("n", "<HOME>", "<NOP>")
vim.keymap.set("i", "<HOME>", "<NOP>")
vim.keymap.set("n", "<END>", "<NOP>")
vim.keymap.set("i", "<END>", "<NOP>")
vim.keymap.set("n", "<PageUp>", "<NOP>")
vim.keymap.set("i", "<PageUp>", "<NOP>")
vim.keymap.set("n", "<PageDown>", "<NOP>")
vim.keymap.set("i", "<PageDown>", "<NOP>")

vim.keymap.set("n", "<Leader>%", "<cmd>:bd %<CR>")
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

-- vim.keymap.set("n", "<leader>h", "<cmd>%!xxd<CR>")
-- vim.keymap.set("n", "<leader>H", "<cmd>%!xxd -r<CR>")
