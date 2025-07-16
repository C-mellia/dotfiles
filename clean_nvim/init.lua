-- variables:
vim.g.mapleader = " "

vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 2
vim.opt.showtabline = 0
vim.opt.number = true

vim.opt.swapfile = false
vim.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.relativenumber = true
-- vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.expandtab = true
-- vim.opt.cinoptions = "(0,ws,Ws,:0,Ls,l1,p0,t0,m1,j1,g0"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- default split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- gives a extra preview window for ed commands like 's'(substitute)
vim.opt.inccommand = "split"

-- allow indent for breaked lines(happens if line is longer than window width)
vim.opt.breakindent = true

-- timeout for keymap sequence
vim.opt.timeoutlen = 300

-- correct formating for cjk characters
vim.opt.formatoptions:append("mB")

-- silence deprecated messages
vim.deprecate = function() end


-- mapping:

vim.keymap.set("n", "<leader>xc", "<cmd>:wa | qa!<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle)

-- avoid fat finger
vim.keymap.set("n", "<HOME>", "<NOP>")
vim.keymap.set("i", "<HOME>", "<NOP>")
vim.keymap.set("n", "<END>", "<NOP>")
vim.keymap.set("i", "<END>", "<NOP>")
vim.keymap.set("n", "<PageUp>", "<NOP>")
vim.keymap.set("i", "<PageUp>", "<NOP>")
vim.keymap.set("n", "<PageDown>", "<NOP>")
vim.keymap.set("i", "<PageDown>", "<NOP>")

vim.keymap.set("n", "<C-t>", "xp")

-- autocmds:
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Strip trailing whitespace before writing a buffer",
	group = vim.api.nvim_create_augroup("kickstart-strip-trailing-whitespace", { clear = true }),
	callback = function()
		vim.fn.execute(":%s/\\s\\+$//e")
	end,
})

