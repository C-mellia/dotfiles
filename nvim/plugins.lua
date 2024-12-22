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

	"Mofiqul/vscode.nvim",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	-- {
	--     "3rd/image.nvim",
	--     opts = {}
	-- },

	-- {
	--     "benlubas/molten-nvim",
	--     version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	--     dependencies = { "3rd/image.nvim" },
	--     build = ":UpdateRemotePlugins",
	--     init = function()
	--         -- this is an example, not a default. Please see the readme for more configuration options
	--         vim.g.molten_image_provider = "image.nvim"
	--         vim.g.molten_output_win_max_height = 20
	--     end,

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
	}, -- },
}, {})
