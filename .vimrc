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

let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

autocmd VimEnter * stopinsert
autocmd VimLeave * startinsert

" Disable automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
call plug#end()

colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

filetype plugin on

" Nerd Tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Keyboard Mapping

nnoremap S :%s//g<Left><Left>
nmap t :NERDTreeToggle<Enter>
