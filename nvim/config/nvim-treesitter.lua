require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "rust", "vimdoc", "go", "cpp", "latex", "javascript", 
        "typescript", "html", "css", "zig", "python", "glsl", "cmake",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = false },
})
