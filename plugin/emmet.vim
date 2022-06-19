let g:user_emmet_mode='i'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global=0
augroup Setup_Emmet
    autocmd!
    autocmd FileType typescriptreact,javascriptreact,html,javascript,css,vue EmmetInstall
augroup END
