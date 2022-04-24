vim.cmd[[
    syntax on

    set path+=**

    " Nice menu when typing `:find *.py`
    set wildmode=longest,list,full
    set wildmenu
    " Ignore files
    set wildignore+=*.pyc
    set wildignore+=*_build/*
    set wildignore+=**/coverage/*
    set wildignore+=**/node_modules/*
    set wildignore+=**/android/*
    set wildignore+=**/ios/*
    set wildignore+=**/.git/*

    " Plugins
    call plug#begin('~/.config/nvim-plugins/plugged')
        " Themes
        Plug 'gruvbox-community/gruvbox'
        Plug 'sickill/vim-monokai'
        Plug 'rebelot/kanagawa.nvim'

        " lsp
        Plug 'neovim/nvim-lspconfig'

        " nvim-cmp
        Plug 'hrsh7th/nvim-cmp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-nvim-lua'
        Plug 'onsails/lspkind-nvim'
        Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

        " luasnip
        Plug 'L3MON4D3/LuaSnip'
        Plug 'saadparwaiz1/cmp_luasnip'
        Plug 'rafamadriz/friendly-snippets'

        " Treesitter
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/playground',
        Plug 'romgrk/nvim-treesitter-context'

        " lualine
        Plug 'nvim-lualine/lualine.nvim'
        Plug 'kyazdani42/nvim-web-devicons'

        " Telescope
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-telescope/telescope-fzy-native.nvim'

        " Git
        Plug 'tpope/vim-fugitive'

        " Undotree
        Plug 'mbbill/undotree'

        " Commenter
        Plug 'numToStr/Comment.nvim'

        " Languages
        Plug 'tomlion/vim-solidity'
        Plug 'ray-x/go.nvim'
        Plug 'rust-lang/rust.vim'

        " Emmet
        Plug 'mattn/emmet-vim'
    call plug#end()

    filetype plugin on


    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    augroup END

    augroup clean_up
        autocmd!
        autocmd BufWritePre * %s/\s\+$//e
        autocmd BufEnter *.go :lua require('go').setup()
        autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    augrou END
]]

function Set_keymap(mode, key, action, opts)
    vim.keymap.set(mode, key, action, opts)
end

Set_keymap("i", "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { silent = true, expr = true })
Set_keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { noremap = true, silent = true })

Set_keymap("s","<Tab>", "<cmd>lua require('luasnip').jump(1)<Cr>", { noremap = true, silent = true })
Set_keymap("s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<Cr>", { noremap = true, silent = true })

Set_keymap("i", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true })
Set_keymap("s", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true })

Set_keymap("n", " Q", "<nop>", { noremap = true, silent = true })

-- Set map leader
vim.g.mapleader=" "
vim.g.snippets="luasnip"

-- Keyboard Mapping

-- For replacing all occurance of a word/patter
Set_keymap("n", "<leader>s", ":%s//g<Left><Left>", { noremap = true })

-- :so will source ~/.vimrc
Set_keymap("n", "<Leader><CR>", ":so ~/.config/nvim/init.lua<CR>", { noremap = true })

-- Change between windows
Set_keymap("n", "<leader>h", ":wincmd h<CR>", {})
Set_keymap("n", "<leader>j", ":wincmd j<CR>", {})
Set_keymap("n", "<leader>k", ":wincmd k<CR>", {})
Set_keymap("n", "<leader>l", ":wincmd l<CR>", {})

-- terminal
Set_keymap("n", "<Leader>t", ":12sp +terminal<CR> i", {})
Set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
Set_keymap("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", { noremap = true })
Set_keymap("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", { noremap = true })
Set_keymap("t", "<Esc>q", "<C-\\><C-n>:q<CR>", { noremap = true })

-- Normalize
Set_keymap("v", "<leader>.", ":norm .<CR>", { noremap = true })

-- A blank line above current line
Set_keymap("n", "<leader>o", "o<Esc>k", {})

-- A blank line above current line
Set_keymap("n", "<leader>O", "O<Esc>j", {})

-- Move selection up or down
Set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
Set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- greatest remap ever
Set_keymap("v", "<leader>p", "\"_dP", { noremap = true })

-- Paste from clipboard
Set_keymap("n", "<leader>p", "\"+p", { noremap = true })

-- next greatest remap ever : asbjornHaland
Set_keymap("n", "<leader>y", "\"+y", { noremap = true })
Set_keymap("v", "<leader>y", "\"+y", { noremap = true })
Set_keymap("n", "<leader>Y", "gg\"+yG", { noremap = true })
Set_keymap("n", "Y", "y$", { noremap = true })

-- delete to non-existance
Set_keymap("n", "<leader>d", "\"_d", { noremap = true })
Set_keymap("v", "<leader>d", "\"_d", { noremap = true })

-- save as root
Set_keymap("n", "<leader>W", ":w !sudo tee %<CR>", { noremap = true })

Set_keymap("i", "<C-c>", "<esc>", { noremap = true })

require("al")

require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
