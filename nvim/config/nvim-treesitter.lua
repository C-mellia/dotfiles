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
        "markdown"
	},
	auto_install = false,
	highlight = {
        enable = true,
        disable = { "latex", },
        additional_vim_regex_highlighting = { "latex", "markdown" },
    },
	indent = { enable = true },
})
