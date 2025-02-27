local trouble = require("trouble")

require("trouble").setup({
	position = "bottom",
	height = 10,
	width = 50,
	mode = "workspace_diagnostics",
	icons = true,
	fold_open = "v", -- icon used for open folds
	fold_closed = ">", -- icon used for closed folds
	indent_lines = false, -- add an indent guide below the fold icons
	signs = {
		-- icons / text used for a diagnostic
		error = "error",
		warning = "warn",
		hint = "hint",
		information = "info",
	},
	action_keys = {
		-- key mappings for actions in the trouble list
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small poup with the full multiline message
		open_split = { "<c-x>" }, -- open buffer in new split
	},
	auto_jump = { "lsp_definition", "lsp_references" },
	use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

vim.keymap.set("n", "<leader>X", function()
	trouble.toggle()
end)
vim.keymap.set("n", "<leader>xf", function()
	trouble.toggle("quickfix")
end)
