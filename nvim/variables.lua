vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.guicursor = "i:block"
vim.opt.showtabline = 0
vim.opt.number = true
vim.opt.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

vim.opt.laststatus = 0
vim.opt.mouse = ""
vim.cmd [[
filetype plugin indent on
]]
vim.opt.swapfile = false
vim.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 5
vim.opt.colorcolumn = "80"

vim.opt.expandtab = true
