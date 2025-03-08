local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

-- (Don't preview binaries)[https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries]
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", "--", filepath },
		on_exit = function(j)
			local result = j:result()[1]
			local mime_type = vim.split(result, "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY: " .. result })
				end)
			end
		end,
	}):sync()
end

require("telescope").setup({
	defaults = {
		buffer_previewer_maker = new_maker,
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
		layout_strategy = "flex",
		layout_config = {
			height = 0.95,
			-- prompt_position = "top",
		},
	},

	pickers = {
		find_files = {
			theme = "ivy",
		},

		git_files = {
			theme = "ivy",
		},

		treesitter = {
			theme = "cursor",
		},

		lsp_document_symbols = {
			theme = "ivy",
		},

		help_tags = {
			theme = "ivy",
		},

		buffers = {
			theme = "ivy",
			mappings = {
				i = {
					["<C-g>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
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
