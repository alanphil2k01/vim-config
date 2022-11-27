local clean_up = vim.api.nvim_create_augroup("clean_up", {})

vim.api.nvim_create_autocmd("BufWritePre",{
    group = clean_up,
    pattern = {"*"},
    callback = function()
        PreserveCursor[[ %s/\s\+$//e ]]
    end
})

vim.api.nvim_create_autocmd("BufEnter",{
    group = clean_up,
    pattern = {"*.go"},
    callback = function()
        require('go').setup()
    end
})

vim.api.nvim_create_autocmd("BufWritePre",{
    group = clean_up,
    pattern = {"*.go"},
    callback = function()
        require('go.format').goimport()
    end
})

-- vim.api.nvim_create_autocmd("BufEnter",{
--     group = clean_up,
--     pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"},
--     callback = function()
--         vim.bo.tabstop = 2
--         vim.bo.softtabstop = 2
--         vim.bo.shiftwidth = 2
--
--     end
-- })
