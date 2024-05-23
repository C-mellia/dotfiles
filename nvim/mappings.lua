local util = require("util")
local builtin = require("telescope.builtin")
local trouble = require("trouble")
-- local oil = require("oil.actions")

vim.keymap.set("n", "<C-j>", "<cmd>:cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>:cprev<CR>")

vim.keymap.set("n", "<leader>xc", "<cmd>:wa | qa!<CR>")
vim.keymap.set("n", "<Leader>`", "<cmd>:e " .. os.getenv("HOME") .. "/.config/nvim/init.lua<CR>")

vim.keymap.set("n", "gd", function()
	builtin.lsp_definitions({
		jump_type = "vsplit",
	})
end)

vim.keymap.set("n", "<leader>G", function()
	builtin.git_files()
end)

vim.keymap.set("n", "<C-p>", function()
	builtin.find_files({
		hidden = false,
	})
end)

vim.keymap.set("n", "<leader>M", function()
	builtin.man_pages({
		sections = { "ALL" },
	})
end)

vim.keymap.set("n", "B", function()
	builtin.buffers()
end)

vim.keymap.set("n", "<Leader>N", function()
	builtin.live_grep()
end)

vim.keymap.set("n", "<Leader>T", function()
	builtin.help_tags()
end)

vim.keymap.set("n", "<C-s>", function()
	builtin.treesitter()
end)

vim.keymap.set("n", "<leader>S", function()
	builtin.colorscheme({
		enable_preview = true,
	})
end)

vim.keymap.set("n", "<C-l>", function()
	builtin.lsp_document_symbols()
end)

-- vim.keymap.set("n", "<Leader>N", "<cmd>:Telescope live_grep<CR>")
-- vim.keymap.set("n", "<Leader>T", "<cmd>:Telescope help_tags<CR>")
-- vim.keymap.set("n", "<C-s>", "<cmd>:Telescope treesitter<CR>")
-- vim.keymap.set("n", "<Leader>C", "<cmd>:Telescope commands<CR>")
-- vim.keymap.set("n", "<leader>S", "<cmd>:Telescope colorscheme enable_preview=true<CR>")
-- vim.keymap.set("n", "<C-l>", "<cmd>:Telescope lsp_document_symbols<CR>")
-- vim.keymap.set("n", "B", "<cmd>:Telescope buffers<CR>")
-- vim.keymap.set("n", "<Leader>M", '<cmd>:Telescope man_pages sections={"ALL"}<CR>')

vim.keymap.set("n", "va/", "[/v]/")
vim.keymap.set("n", "va/", "[/v]/d")
vim.keymap.set("n", "va/", "[/v]/c")

vim.keymap.set("n", "vi/", "[/wv]/")
vim.keymap.set("n", "vi/", "[/wv]/d")
vim.keymap.set("n", "vi/", "[/wv]/c")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<HOME>", "<NOP>")
vim.keymap.set("i", "<HOME>", "<NOP>")
vim.keymap.set("n", "<END>", "<NOP>")
vim.keymap.set("i", "<END>", "<NOP>")
vim.keymap.set("n", "<PageUp>", "<NOP>")
vim.keymap.set("i", "<PageUp>", "<NOP>")
vim.keymap.set("n", "<PageDown>", "<NOP>")
vim.keymap.set("i", "<PageDown>", "<NOP>")

vim.keymap.set("n", "<Leader>a(", "viw<ESC>a)<ESC>bi(<ESC>")
vim.keymap.set("n", "<Leader>a)", "viw<ESC>a)<ESC>bi(<ESC>")
vim.keymap.set("n", "<Leader>a[", "viw<ESC>a]<ESC>bi[<ESC>")
vim.keymap.set("n", "<Leader>a]", "viw<ESC>a]<ESC>bi[<ESC>")
vim.keymap.set("n", "<Leader>a{", "viw<ESC>a}<ESC>bi{<ESC>")
vim.keymap.set("n", "<Leader>a}", "viw<ESC>a}<ESC>bi{<ESC>")
vim.keymap.set("n", "<Leader>a<", "viw<ESC>a><ESC>bi<lt><ESC>")
vim.keymap.set("n", "<Leader>a>", "viw<ESC>a><ESC>bi<lt><ESC>")
vim.keymap.set("n", "<Leader>a'", "viw<ESC>a'<ESC>bi'<ESC>")
vim.keymap.set("n", '<Leader>a"', 'viw<ESC>a"<ESC>bi"<ESC>')

-- '"([asodjashiouwehf])"'

vim.keymap.set("n", "<Leader>%", "<cmd>:bd %<CR>")
vim.keymap.set("n", "<Leader>gg", function()
	vim.cmd('normal viw"0y')
	util.grep_from_dir_reg("0")
end)
vim.keymap.set("n", "<Leader>cc", function()
	vim.cmd('normal viw"0y')
	util.grep_from_buf_reg("0")
end)
vim.keymap.set("n", "<Leader>gr", function()
	util.grep_from_buf_reg("+")
end)
vim.keymap.set("n", "<Leader>cr", function()
	util.grep_from_buf_reg("+")
end)
vim.keymap.set("n", "<C-t>", "xp")

vim.keymap.set("n", "<Leader>d(", "di(vhP")
vim.keymap.set("n", "<Leader>d[", "di[vhP")
vim.keymap.set("n", "<Leader>d{", "di{vhP")
vim.keymap.set("n", "<Leader>d<lt>", "di<lt>vhP")
vim.keymap.set("n", "<Leader>d'", "di'vhP")
vim.keymap.set("n", '<Leader>d"', 'di"vhP')

-- "apsijdpoasijd"

vim.keymap.set("n", "<leader>s", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>X", function()
	trouble.toggle()
end)
vim.keymap.set("n", "<leader>xf", function()
	trouble.toggle("quickfix")
end)

vim.keymap.set("n", "<leader>ee", "Oif err != nil {<C-M>}<Esc>Opanic(err)<Esc>++")

vim.keymap.set("n", "<leader>D", "<cmd>Oil<cr>")
-- vim.keymap.set("n", "<leader>D", oil.open_cwd.callback)
-- vim.keymap.set("n", "<leader>D", "<cmd>NvimTreeOpen<cr>")
