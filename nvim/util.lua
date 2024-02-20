return {
    grep_from_dir_reg = function(reg)
        if type(reg) == "string" then
            vim.cmd('vimgrep ' .. vim.fn.getreg(reg) .. ' ./*')
            vim.cmd('copen')
        end
    end,
    grep_from_buf_reg = function(reg)
        if type(reg) == "string" then
            vim.cmd('vimgrep ' .. vim.fn.getreg(reg) .. ' %')
            vim.cmd('copen')
        end
    end,
}
