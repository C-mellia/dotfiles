-- local builtin = require("telescope.builtin")
local util = require("util")

vim.g.mapleader = ' '
vim.keymap.set('i', '<C-f>', '<C-o>a')
vim.keymap.set('i', '<C-b>', '<C-o>h')
vim.keymap.set('i', '<C-e>', '<C-o>A')
vim.keymap.set('i', '<C-a>', '<C-o>I')
vim.keymap.set('n', '<Leader>xc', '<cmd>:wa | qa!<CR>')
vim.keymap.set('n', '<Leader>1', '<cmd>:only!<CR>')
vim.keymap.set('n', '<Leader>0', '<cmd>: close<CR>')
vim.keymap.set('n', '<Leader>o', '<C-w>w')
vim.keymap.set('n', '<Leader>2', '<cmd>:split<CR>')
vim.keymap.set('n', '<Leader>3', '<cmd>:vsplit<CR>')
vim.keymap.set('n', '<Leader>r', '<cmd>:w | e!<CR>')
vim.keymap.set('n', '<Leader>d', "<cmd>:NvimTreeToggle<CR>")
vim.keymap.set('n', '<Leader>`', "<cmd>:e /home/camellia/.config/nvim/init.lua<CR>")

vim.keymap.set('n', '<C-f>', "<cmd>:cn<CR>")
vim.keymap.set('n', '<C-b>', "<cmd>:cp<CR>")

-- vim.keymap.set('n', 'Th', "<cmd>:resize +1<CR>")
-- vim.keymap.set('n', 'Tv', '<cmd>:vertical resize<CR>')

vim.keymap.set('n', '<Leader>tf', "<cmd>:Telescope find_files<CR>")
vim.keymap.set('n', '<Leader>tb', "<cmd>:Telescope buffers<CR>")
vim.keymap.set('n', '<Leader>tg', "<cmd>:Telescope live_grep<CR>")
vim.keymap.set('n', '<Leader>tt', "<cmd>:Telescope help_tags<CR>")
vim.keymap.set('n', '<Leader>ts', "<cmd>:Telescope treesitter<CR>")
vim.keymap.set('n', '<Leader>tcf', "<cmd>:Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set('n', '<Leader>tcd', "<cmd>:Telescope commands<CR>")
vim.keymap.set('n', '<Leader>tm', '<cmd>:Telescope man_pages sections={"ALL"}<CR>')
vim.keymap.set('n', '<Leader>tcs', "<cmd>:Telescope colorscheme enable_preview=true<CR>")
vim.keymap.set('n', '<Leader>tk', "<cmd>:Telescope keymaps<CR>")
vim.keymap.set('n', '<Leader>tls', "<cmd>:Telescope lsp_document_symbols<CR>")
vim.keymap.set('n', '<Leader>tvo', "<cmd>:Telescope vim_options<CR>")

vim.keymap.set('n', '<Leader>aa/', '[/v]/')
vim.keymap.set('n', '<Leader>aa/', '[/v]/d')
vim.keymap.set('n', '<Leader>aa/', '[/v]/c')

vim.keymap.set('n', '<Leader>ai/', '[/wv]/')
vim.keymap.set('n', '<Leader>ai/', '[/wv]/d')
vim.keymap.set('n', '<Leader>ai/', '[/wv]/c')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set('n', '<HOME>', '<NOP>')
vim.keymap.set('i', '<HOME>', '<NOP>')
vim.keymap.set('n', '<END>', '<NOP>')
vim.keymap.set('i', '<END>', '<NOP>')
vim.keymap.set('n', '<PageUp>', '<NOP>')
vim.keymap.set('i', '<PageUp>', '<NOP>')
vim.keymap.set('n', '<PageDown>', '<NOP>')
vim.keymap.set('i', '<PageDown>', '<NOP>')

vim.keymap.set('n', '<Leader>a(', 'viw<ESC>a)<ESC>bi(<ESC>')
vim.keymap.set('n', '<Leader>a)', 'viw<ESC>a)<ESC>bi(<ESC>')
vim.keymap.set('n', '<Leader>a[', 'viw<ESC>a]<ESC>bi[<ESC>')
vim.keymap.set('n', '<Leader>a]', 'viw<ESC>a]<ESC>bi[<ESC>')
vim.keymap.set('n', '<Leader>a{', 'viw<ESC>a}<ESC>bi{<ESC>')
vim.keymap.set('n', '<Leader>a}', 'viw<ESC>a}<ESC>bi{<ESC>')
vim.keymap.set('n', '<Leader>a<', 'viw<ESC>a><ESC>bi<lt><ESC>')
vim.keymap.set('n', '<Leader>a>', 'viw<ESC>a><ESC>bi<lt><ESC>')
vim.keymap.set('n', "<Leader>a'", "viw<ESC>a'<ESC>bi'<ESC>")
vim.keymap.set('n', '<Leader>a"', 'viw<ESC>a"<ESC>bi"<ESC>')

-- '"([asodjashiouwehf])"' 

vim.keymap.set('n', "<Leader>%", "<cmd>:bd %<CR>")
vim.keymap.set('n', "<Leader>gg", function()
    vim.cmd('normal viw"0y')
    util.grep_from_dir_reg('0')
end)
vim.keymap.set('n', "<Leader>cc", function()
    vim.cmd('normal viw"0y')
    util.grep_from_buf_reg('0')
end)
vim.keymap.set('n', "<Leader>gr", function()
    util.grep_from_buf_reg('+')
end)
vim.keymap.set('n', "<Leader>cr", function()
    util.grep_from_buf_reg('+')
end)
vim.keymap.set('n', "<C-j>", "Lzz")
vim.keymap.set('n', "<C-k>", "Hzz")
vim.keymap.set('n', "t", "xp")
vim.keymap.set('v', "<C-h>", "xhPgvhoho")
vim.keymap.set('v', "<C-l>", "xpgvlolo")
