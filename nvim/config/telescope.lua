local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})

vim.keymap.set("n", "gd", function()
	builtin.lsp_definitions({
		jump_type = "vsplit",
	})
end)

vim.keymap.set("n", "<leader>G", function()
	builtin.git_files()
end)

vim.keymap.set("n", "<C-p>", function()
	builtin.find_files({
		hidden = false,
	})
end)

vim.keymap.set("n", "<leader>M", function()
	builtin.man_pages({
		sections = { "ALL" },
	})
end)

vim.keymap.set("n", "B", function()
	builtin.buffers()
end)

vim.keymap.set("n", "<Leader>N", function()
	builtin.live_grep()
end)

vim.keymap.set("n", "<Leader>T", function()
	builtin.help_tags()
end)

vim.keymap.set("n", "<C-s>", function()
	builtin.treesitter()
end)

vim.keymap.set("n", "<leader>S", function()
	builtin.colorscheme({
		enable_preview = true,
	})
end)

vim.keymap.set("n", "<C-l>", function()
	builtin.lsp_document_symbols()
end)
