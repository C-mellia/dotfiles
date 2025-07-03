vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.smartcase = true

vim.opt.path:append("/usr/local/include")
vim.opt.path:append("/opt/cuda/include")
for _, path in ipairs(vim.fn.glob("/usr/include/c++/*", true, true)) do
	vim.opt.path:append(path)
end
vim.opt.path:append(os.getenv("HOME") .. "/.local/include")
if os.getenv("PWD") ~= nil then
	vim.opt.path:append(os.getenv("PWD") .. "/include")
else
	vim.notify("Failed to append include path under current workspace", vim.log.levels.WARN)
end

-- vim.opt.indentkeys:append(">")
-- vim.opt.guicursor = "i:block"
vim.opt.showtabline = 0
vim.opt.number = true
-- vim.opt.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- minimum status line
vim.opt.laststatus = 2
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

-- hidden or replace concealed characters
vim.opt.conceallevel = 2
-- conceal settings for vimtex
vim.g.tex_conceal = "abdmgs"

-- correct formating for cjk characters
vim.opt.formatoptions:append("mB")

-- darkmode for vscode color theme
vim.opt.background = "dark"
-- vim.opt.background = "light"

vim.g.copilot_proxy = "http://localhost:20171"

-- disable indent for align environment in latex
vim.g.vimtex_indent_on_ampersands = 0

-- silence deprecated messages
vim.deprecate = function() end
