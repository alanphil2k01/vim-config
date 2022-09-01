vim.opt.path:append("**")
vim.opt.wildmode = "longest,list,full"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.errorbells = false

vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.showtabline = 2
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.encoding = "UTF-8"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME .. "/.config/nvim-plugins/undodir"

vim.opt.hidden = true
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
-- Line below a comment will not be a comment
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove("c")
        vim.opt_local.formatoptions:remove("r")
        vim.opt_local.formatoptions:remove("o")
    end
})

vim.g.mapleader=" "
vim.g.snippets="luasnip"
