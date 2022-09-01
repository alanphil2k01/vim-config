vim.g.user_emmet_mode='i'
vim.g.user_emmet_leader_key=','
vim.g.user_emmet_install_global=0

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("EmmetSetup", {}),
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.html", "*.css" },
    callback = function() vim.cmd [[EmmetInstall]] end
})
