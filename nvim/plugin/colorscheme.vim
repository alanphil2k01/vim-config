" gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

" Transparency
hi Normal guibg=NONE

" js, ts and sol files will have monokai
let g:molokai_original = 1
let g:rehash256 = 1
autocmd BufEnter *.js,*.ts,*.sol colorscheme molokai

" java
autocmd BufEnter *.java colorscheme onedark

" golang
autocmd BufEnter *.go set notermguicolors
autocmd BufEnter *.go colorscheme nord

" Airline theme
autocmd BufEnter * :AirlineRefresh
