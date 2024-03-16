vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.indentkeys:append(">")
-- vim.opt.guicursor = "i:block"
vim.opt.showtabline = 0
vim.opt.number = true
-- vim.opt.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

vim.opt.laststatus = 0
-- vim.opt.mouse = ""
vim.cmd([[
filetype plugin indent on
]])
vim.opt.swapfile = false
vim.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- vim.opt.cindent = true
-- vim.opt.autoindent = true
-- vim.opt.smartindent = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- vim.opt.expandtab = true
-- vim.opt.cinoptions = "(0,ws,Ws,:0,Ls,l1,p0,t0,m1,j1,g0"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.breakindent = true
vim.opt.timeoutlen = 300
