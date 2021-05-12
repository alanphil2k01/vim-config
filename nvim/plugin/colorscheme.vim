let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
let g:airline_theme = 'dracula'

set background=dark
colorscheme dracula
hi Normal guibg=NONE
au BufEnter *.c,*.cpp,*.h,*.vim,*.rs,*.sh,Makefile,*.toml,*.json,*.conf colorscheme gruvbox 
au BufEnter *.c,*.cpp,*.h,*.vim,*.rs,*.sh,Makefile,*.toml,*.json,*.conf let g:airline_theme = 'gruvbox'
au BufEnter *.c,*.cpp,*.h,*.vim,*.rs,*.sh,Makefile,*.toml,*.json,*.conf hi Normal guibg=NONE
au BufEnter * :AirlineRefresh
