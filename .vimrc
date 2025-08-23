set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent
"set expandtab

set noswapfile
filetype plugin indent on
set cursorline
set nohlsearch
set incsearch
set relativenumber
set nu

set termguicolors
set lazyredraw
set scrolloff=6
set colorcolumn=80
set updatetime=50
colorscheme retrobox
set autoread
set laststatus=0
set noswapfile

set isfname+=@-@

set splitright
set splitbelow

set breakindent

syntax enable

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

set clipboard=unnamedplus

"set list
"set listchars=tab:»\ ,trail:·,nbsp:␣

"colorscheme evening
