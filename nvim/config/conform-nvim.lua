local conform = require("conform")
conform.setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		css = { { "prettierd", "prettier" } },
		lua = { "stylua" },
		html = { "htmlbeautifier" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		sql = { "sqlfmt" },
		sh = { "beautysh" },
		zsh = { "beautysh" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
