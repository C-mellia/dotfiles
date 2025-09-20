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

-- 'm' is crucial for formatting CJK words, however it has some unwanted line
-- breaks for some combinations of characters, for example:
--
-- `<head>`. in this case the line break can happen between '>' and the second
-- backtick, resulting in Obsidian not able to recognize the markdown syntax.
--
-- Manually toggling 'm' is annoying, but at least it's a workaround. Also in
-- my case, I probably won't be working with both at the same time.
vim.keymap.set("n", "<leader>e", function()
	if vim.bo.formatoptions:match("m") then
		vim.bo.formatoptions = vim.bo.formatoptions:gsub("m", "")
		print("formatoptions: 'm' removed")
	else
		vim.bo.formatoptions = vim.bo.formatoptions .. "m"
		print("formatoptions: 'm' added")
	end
end, { desc = "toggle formatoptions 'm'" })

-- vim.keymap.set("n", "<leader>h", "<cmd>%!xxd<CR>")
-- vim.keymap.set("n", "<leader>H", "<cmd>%!xxd -r<CR>")
