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

    " Theme
    Plug 'gruvbox-community/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula'}

    " Emmet
    Plug 'mattn/emmet-vim'

    " Lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/playground',

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " Git
    Plug 'tpope/vim-fugitive'

    " Undotree
    Plug 'mbbill/undotree'
    Plug 'preservim/nerdcommenter'

    " GoFmt
    Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Set map leader
let mapleader=" "

filetype plugin on

" Keyboard Mapping

" For replacing all occurance of a word/patter
nnoremap <leader>s :%s//g<Left><Left>

" :so will source ~/.vimrc
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" Change between windows
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>

" terminal
nmap <Leader>t :14sp +terminal<CR> i
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <Esc>q <C-\><C-n>:q<CR>

" Normalize
vnoremap <leader>. :norm .<CR>

" A blank line above current line
nmap <leader>o o<Esc>k

" A blank line above current line
nmap <leader>O O<Esc>j

" Move selection up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
vnoremap <leader>p "_dP

" Paste from clipboard
nnoremap <leader>p "+p

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap Y y$

" delete to non-existance
nnoremap <leader>d "_d
vnoremap <leader>d "_d

inoremap <C-c> <esc>

lua require("al")

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup clean_up
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWrite *.go GoFmt
    autocmd BufWrite *.go GoImports
augrou END