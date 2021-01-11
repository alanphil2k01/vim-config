" NerdTree
let NERDTreeQuitOnOpen=1 " Closes nerdtree when a file is opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Opens nerdtree if no file is specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Autoclose nerdtree when other windows are closed

" Open NerdTree
nnoremap <Leader>e :NERDTree<CR>
