local lspconf = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconf.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconf.jdtls.setup({
	capabilities = capabilities,
	cmd = { "jdtls" },
	-- root_dir = vim.fn.getcwd,
})

lspconf.arduino_language_server.setup({
	capabilities = capabilities,
})

lspconf.gdscript.setup({
	capabilities = capabilities,
})

lspconf.tailwindcss.setup({
	capabilities = capabilities,
})

lspconf.templ.setup({
	capabilities = capabilities,
})

lspconf.htmx.setup({
	capabilities = capabilities,
})

lspconf.cmake.setup({
	capabilities = capabilities,
})

lspconf.html.setup({
	capabilities = capabilities,
})

lspconf.svelte.setup({
	capabilities = capabilities,
})

lspconf.pyright.setup({
	capabilities = capabilities,
})

lspconf.glsl_analyzer.setup({
	capabilities = capabilities,
})

lspconf.zls.setup({
	capabilities = capabilities,
})

lspconf.texlab.setup({
	capabilities = capabilities,
})

-- lspconf.clangd.setup({
--     capabilities = capabilities,
--     -- handlers = {
--     --     ["textDocument/publishDiagnostics"] = function ()
--     --     end,
--     --},
-- })

lspconf.eslint.setup({
	capabilities = capabilities,
})

lspconf.ts_ls.setup({
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
})

lspconf.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		diagnostics = {
			enable = true,
		},
	},
	workspace = {
		didChangeConfiguration = {
			dynamicRegistration = false,
		},
	},
})

lspconf.gopls.setup({
	capabilities = capabilities,
})

lspconf.bashls.setup({
	capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition({ jump_type = "vsplit" }), opts)
		vim.keymap.set("n", "<space>lh", vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<space>ls', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wl', function()
		--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		-- vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
		-- vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>ld", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>m", vim.lsp.buf.format, opts)
		-- vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		--     vim.keymap.set('n', '<space>f', function()
		--         vim.lsp.buf.format { async = true }
		--     end, opts)
	end,
})
