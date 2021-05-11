" global theme variables
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
set background=dark
let g:airline_theme = 'onedark'

" Set colorscheme based on type of file
function! SetColorScheme()
    if &ft == 'go' || &ft == 'java'
        colorscheme afterglow
        let g:airline_theme = 'afterglow'
    elseif &ft == 'js' || &ft == 'ts' || &ft == 'sol' || &ft == 'vue'
        colorscheme monokai
    else
        colorscheme gruvbox
    endif
endfunction

" Use gruvbox when entering vim without specifying any file
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | colorscheme gruvbox | hi NOrmal guibg=NONE | else | call SetColorScheme() | hi Normal guibg=NONE | endif " Sets colorscheme if no file is specified

" Change colorscheme when a new file is open
augroup SetTheme
    au!
    au BufRead * call SetColorScheme() | hi Normal guibg=NONE
    au BufEnter * :AirlineRefresh
augroup end
