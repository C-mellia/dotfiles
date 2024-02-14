require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "rust", "vimdoc", "go", "cpp", "latex", "javascript", "typescript", "html", "css",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = false },
})
