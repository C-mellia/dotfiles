local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"nvim-treesitter/nvim-treesitter",

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },

	{
		"stevearc/oil.nvim",
		opts = {},
		lazy = false,
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	"stevearc/dressing.nvim",

	{
		"numToStr/Comment.nvim",
		lazy = false,
	},

	"onsails/lspkind-nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	"crispybaccoon/evergarden",

	"ThePrimeagen/vim-be-good",

	"ramojus/mellifluous.nvim",

	"mbbill/undotree",

	"tpope/vim-fugitive",

	"winston0410/range-highlight.nvim",

	"EdenEast/nightfox.nvim",

	"ellisonleao/gruvbox.nvim",

	{ "rose-pine/neovim", name = "rose-pine" },

	"github/copilot.vim",

	"folke/trouble.nvim",

	"folke/tokyonight.nvim",

	"catppuccin/nvim",

	"rebelot/kanagawa.nvim",

	{
		"stevearc/conform.nvim",
		opts = {},
	},

	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
}, {})
