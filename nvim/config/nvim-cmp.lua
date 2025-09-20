local cmp = require("cmp")

cmp.setup({
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol",
			before = function(_, vim_item)
				-- [https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499] fix formatting
				local truncated_label = vim.fn.strcharpart(vim_item.menu, 0, 24)
				if truncated_label ~= vim_item.menu then
					vim_item.menu = truncated_label .. "…"
				end
				return vim_item
			end,
		}),
	},

	autocomplete = false,

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	window = {
		-- completion = {
		-- 	side_padding = 0,
		-- },
		-- documentation = {
		-- 	max_width = 80,
		-- },
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-x>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		-- { name = 'buffer' },
		{ name = "path" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
