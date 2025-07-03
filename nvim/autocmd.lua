vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Strip trailing whitespace before writing a buffer",
	group = vim.api.nvim_create_augroup("kickstart-strip-trailing-whitespace", { clear = true }),
	callback = function()
		vim.fn.execute(":%s/\\s\\+$//e")
	end,
})

vim.api.nvim_create_autocmd({
	"BufRead",
	"BufNewFile",
}, {
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "cpp" and ev.file:match("%.h$") then
			print(ev.file)
			vim.cmd([[ set ft=c ]])
		end
	end,
})
