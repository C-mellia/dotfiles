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
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"nvim-treesitter/nvim-treesitter",

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	"stevearc/dressing.nvim",

	{
		"numToStr/Comment.nvim",
		lazy = false,
	},

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

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	"crispybaccoon/evergarden",

	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
	},

	"smjonas/live-command.nvim",

	"ThePrimeagen/vim-be-good",

	"ojroques/nvim-hardline",

	"ramojus/mellifluous.nvim",

	"mbbill/undotree",

	"tpope/vim-fugitive",

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"winston0410/range-highlight.nvim",

	"EdenEast/nightfox.nvim",

	"ellisonleao/gruvbox.nvim",

	{ "rose-pine/neovim", name = "rose-pine" },

	"github/copilot.vim",

	"stevearc/conform.nvim",

	"folke/trouble.nvim",

	{
		"folke/noice.nvim",
		events = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}, {})
