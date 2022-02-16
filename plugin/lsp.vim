" " LSP config (the mappings used in the default file don't quite work right)
nnoremap <leader>rl <cmd>LspRestart()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
