require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	cleanup_delay_ms = 2000,
	delete_to_trash = false,
	constrain_cursor = "name",
	experimental_watch_for_changes = true,
	keymaps = {
		["g?"] = "actions.show_help",
		["<C-h>"] = "actions.parent",
		["<C-l>"] = "actions.select",
		["r"] = "actions.refresh",
		["<C-s>"] = "actions.change_sort",
		["."] = "actions.open_cmdline",
		["g."] = "actions.toggle_hidden",
		["yy"] = "actions.copy_entry_path",
	},
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name, _)
			return vim.startswith(name, ".")
		end,
	},
	use_default_keymaps = false,
	show_hidden = true,
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "<leader>D", "<cmd>Oil<cr>")
-- vim.keymap.set("n", "<leader>D", oil.open_cwd.callback)
