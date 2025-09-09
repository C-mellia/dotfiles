local augroup = vim.api.nvim_create_augroup("user-autocmd", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Strip trailing whitespace before writing a buffer",
	group = augroup,
	callback = function()
		vim.fn.execute(":%s/\\s\\+$//e")
	end,
})

-- vim.api.nvim_create_autocmd({
-- 	"BufRead",
-- 	"BufNewFile",
-- }, {
-- 	group = augroup,
-- 	callback = function(ev)
-- 		if vim.bo[ev.buf].filetype == "cpp" and ev.file:match("%.h$") then
-- 			print(ev.file)
-- 			vim.cmd([[ set ft=c ]])
-- 		end
-- 	end,
-- })

-- having issue with oil-nvim
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = augroup,
-- 	callback = function(_)
-- 		local dir = vim.fn.expand("<afile>:p:h")
-- 		if vim.fn.isdirectory(dir) then
-- 			vim.fn.mkdir(dir, "p")
-- 		end
-- 	end,
-- })
