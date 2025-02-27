require("conform").setup({
	formatters_by_ft = {
		go = { "gofmt" },
		lua = { "stylua" },
		-- python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },

		cpp = { "clang-format" },
		sql = { "sql_formatter", "sqlfmt", stop_after_first = true },
		bash = { "shellharden" },

		javascript = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		svelte = { "prettierd", "prettier", stop_after_first = true },
	},

	-- format_on_save = {
	-- 	lsp_format = "fallback",
	-- 	timeout_ms = 500,
	-- },

	-- format_after_save = {
	-- 	lsp_format = "fallback",
	-- },

	-- formatters = {
	-- 	sql_formatter = {
	-- 		command = "sql-formatter",
	-- 		args = { "--language", "SQLite" },
	-- 		-- stdin = true,
	-- 	},
	-- },
})

vim.keymap.set("n", "<leader>cf", '<cmd>lua require("conform").format()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if not require("conform").format({ bufnr = args.buf }) then
			-- vim.notify("Failed to format file", vim.log.levels.WARN)
			return false
		end
	end,
})
