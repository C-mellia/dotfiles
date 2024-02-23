return {
    grep_from_dir_reg = function(reg)
        if type(reg) == "string" then
            vim.cmd('vim /' .. vim.fn.getreg(reg) .. '/g ./**')
            vim.cmd('copen')
        end
    end,
    grep_from_buf_reg = function(reg)
        if type(reg) == "string" then
            vim.cmd('vim /' .. vim.fn.getreg(reg) .. '/g %')
            vim.cmd('copen')
        end
    end,
}
