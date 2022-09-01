function PreserveCursor(cmd)
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd(cmd)
    local lastline = vim.fn.line("$")
    if line > lastline then
        line = lastline
    end
    vim.api.nvim_win_set_cursor(0, { line, col })
end

vim.api.nvim_create_autocmd("TextYankPost",{
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    pattern = {"*"},
    callback = function()
        vim.highlight.on_yank({timeout = 40})
    end
})
