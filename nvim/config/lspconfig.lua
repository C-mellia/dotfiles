local lspconf = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local opts = {
	capabilities = capabilities,
}

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconf[server_name].setup(opts)
	end,

	["lua_ls"] = function()
		lspconf.lua_ls.setup({
			unpack(opts),
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths here.
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				})
			end,

			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,

	["elixirls"] = function()
		lspconf.elixirls.setup({
			unpack(opts),
			cmd = { os.getenv("HOME") .. "/.local/bin/language_server.sh" },
		})
	end,

	["jdtls"] = function()
		lspconf.jdtls.setup({
			unpack(opts),
			cmd = { "jdtls" },
			-- root_dir = vim.fn.getcwd,
		})
	end,

	["rust_analyzer"] = function()
		lspconf.rust_analyzer.setup({
			unpack(opts),
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
	end,

	["clangd"] = function()
		lspconf.clangd.setup({
			unpack(opts),
			on_attach = function(client, bufnr)
				local filetype = vim.bo[bufnr].filetype
				if filetype == "c" then
					client.stop()
				end
			end,
			-- handlers = {
			--     ["textDocument/publishDiagnostics"] = function ()
			--     end,
			--},
		})
	end,

	["sorbet"] = function()
		lspconf.rubocop.setup({
			capabilities = capabilities,
			cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
		})
	end,

	["rubocop"] = function()
		lspconf.rubocop.setup({
			capabilities = capabilities,
			cmd = { "bundle", "exec", "rubocop", "--lsp" },
		})
	end,
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
