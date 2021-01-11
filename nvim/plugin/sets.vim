set exrc
set nu
set relativenumber
set incsearch
set nohlsearch
set noerrorbells
set scrolloff=8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set showtabline=2
set nowrap
set noswapfile
set nobackup
set undofile
set undodir=~/.config/nvim/undodir
set clipboard+=unnamedplus
set splitbelow
set termguicolors
set signcolumn=yes
set encoding=UTF-8
set hidden
set colorcolumn=100

" needed for coc
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Disable automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
