syntax on

" Plugins
call plug#begin('~/.config/nvim/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'gruvbox-community/gruvbox'
    Plug 'crusoexia/vim-monokai'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'stsewd/fzf-checkout.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'mbbill/undotree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'danilo-augusto/vim-afterglow'
    Plug 'mattn/emmet-vim'
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

" Delete without overwriting yank
vnoremap <leader>d "_dP

" Normalize
vnoremap <leader>. :norm .<CR>

" A blank line above current line
nmap <leader>o o<Esc>k

" A blank line above current line
nmap <leader>O O<Esc>j

" tabs
nmap <leader><TAB> :tabnext<CR>
nmap <leader><s-TAB> :tabprevious<CR>
nmap <leader>n :tabnew 
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
