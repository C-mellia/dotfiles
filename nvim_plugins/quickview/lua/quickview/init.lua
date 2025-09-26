local QV = {}

local grp = vim.api.nvim_create_augroup("QuickView", { clear = true })

local float_config = {
	relative = "editor",
	row = math.floor(vim.o.lines * 0.1),
	col = math.floor(vim.o.columns * 0.1),
	width = math.floor(vim.o.columns * 0.8),
	height = math.floor(vim.o.lines * 0.8),
	border = "rounded",
	style = "minimal",
	focusable = true,
}

local function copy_buf_options(src_buf, dest_buf)
  -- List of buffer-local options you care about
  local opts = {
    "filetype",
    "swapfile",
    "bufhidden",
    "shiftwidth",
    "tabstop",
    "expandtab",
    "textwidth",
  }

  for _, opt in ipairs(opts) do
		vim.bo[dest_buf][opt] = vim.bo[src_buf][opt]
  end
end

function QV.spawn_float_and_copy(opts)
	local cur_buf = vim.api.nvim_get_current_buf()
	local cur_win = vim.api.nvim_get_current_win()

	local new_buf = vim.api.nvim_create_buf(false, true)
	local new_win = vim.api.nvim_open_win(new_buf, true, float_config)

	vim.api.nvim_create_autocmd("BufLeave", {
		group = grp,
		callback = function()
			pcall(vim.api.nvim_buf_delete, new_buf, { unload = true })
		end,
		buffer = new_buf,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = grp,
		callback = function(ev)
			vim.api.nvim_buf_delete(new_buf, { unload = true })
		end,
		buffer = new_buf,
	})

	vim.keymap.set("n", "q", function()
		vim.api.nvim_buf_delete(new_buf, { unload = true })
	end, { buffer = new_buf })

	local line1, line2 = opts.line1, opts.line2
	local lines = vim.api.nvim_buf_get_lines(cur_buf, line1 - 1, line2, true)
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, true, lines)

	vim.opt.number = true
	vim.opt.cursorline = true

	copy_buf_options(cur_buf, new_buf)
	vim.api.nvim_exec_autocmds("FileType", { buffer = new_buf })
end

function QV.setup()
	vim.api.nvim_create_user_command(
		"QV",
		QV.spawn_float_and_copy,
		{
			range = true,
			nargs = 0,
		}
	)
end

return QV
