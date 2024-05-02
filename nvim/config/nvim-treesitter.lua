require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"vimdoc",
        "vim",
		"go",
		"javascript",
		"typescript",
		"html",
		"css",
		"zig",
		"python",
	},
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
