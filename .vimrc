syntax on

set nu
set incsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard+=unnamedplus

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'morhetz/gruvbox'
call plug#end()

colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

filetype plugin on

" Keyboard Mapping

nnoremap S :%s//g<Left><Left>
