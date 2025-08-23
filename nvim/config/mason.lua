local global_conf = require("global_conf")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local opts = {
	capabilities = capabilities,
}

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = global_conf.mason_ensure_installed,
	automatic_enable = true,
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
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

vim.lsp.config("elixirls", {
	unpack(opts),
	cmd = { os.getenv("HOME") .. "/.local/bin/language_server.sh" },
})

vim.lsp.config("jdtls", {
	unpack(opts),
	cmd = { "jdtls" },
	-- root_dir = vim.fn.getcwd,
})

vim.lsp.config("rust_analyzer", {
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

vim.lsp.config("clangd", {
	unpack(opts),
	on_attach = function(client, bufnr)
		local filetype = vim.bo[bufnr].filetype
		if filetype ~= "cpp" then
			client.stop()
		end
	end,
	-- handlers = {
	--     ["textDocument/publishDiagnostics"] = function ()
	--     end,
	--},
})

vim.lsp.config("sorbet", {
	unpack(opts),
	cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
})

vim.lsp.config("rubocop", {
	unpack(opts),
	cmd = { "bundle", "exec", "rubocop", "--lsp" },
})

vim.lsp.config("hls", {
	unpack(opts),
	filetypes = { "haskell", "lhaskell", "cabal" },
	cmd = { "cabal", "exec", "haskell-language-server-wrapper", "--", "--lsp" },
})
