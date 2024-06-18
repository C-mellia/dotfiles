require("conform").setup({
    formatters_by_ft = {
        go = { "gofmt" },
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
