require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "rust", "vimdoc", "go", "cpp", "latex", "javascript",
        "typescript", "html", "css", "zig", "python", "glsl", "cmake", "templ",
        "ocaml",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})
