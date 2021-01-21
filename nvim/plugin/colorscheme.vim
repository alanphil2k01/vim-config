" gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

" Transparency
hi Normal guibg=NONE

" js, ts and sol files will have monokai
autocmd BufEnter *.js,*.ts,*.sol colorscheme monokai

" java
autocmd BufEnter *.java colorscheme onedark

" golang
autocmd BufEnter *.go set notermguicolors
autocmd BufEnter *.go colorscheme nord

" Airline theme
autocmd BufEnter * :AirlineRefresh
