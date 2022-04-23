let g:my_colorscheme = "kanagawa"

fun! ColorMyVim()
    let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    set background=dark
    call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:my_colorscheme])

    hi ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    hi Normal guibg=none
    hi netrwDir guifg=#5eacd3
    hi LineNr guifg=#5eacd3
    hi LineNr guibg=none
    hi netrwDir guifg=#5eacd3
    hi qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun

nnoremap <leader>cwm :call ColorMyVim()<CR>
nnoremap <leader>vwm :let g:my_colorscheme = ""<Left>

call ColorMyVim()
