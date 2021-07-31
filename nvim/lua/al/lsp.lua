local function on_attach()
end

-- npm i -g typescript-language-server
require'lspconfig'.tsserver.setup{ on_attach=on_attach }

-- npm i -g vim-language-server
require'lspconfig'.vimls.setup{ on_attach=on_attach }

-- package clang or clangd
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.gopls.setup{
    on_attach=on_attach,
    cmd = {"gopls", "serve"},
    root_dir = function() return vim.loop.cwd() end,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

-- rustup +nightly component add rust-analyzer-preview
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

local sumneko_root_path = '/home/alan/Projects/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}


-- npm i -g bash-language-server
require'lspconfig'.bashls.setup { on_attach = on_attach }

-- npm i -g svelte-language-server
require'lspconfig'.svelte.setup { on_attach = on_attach }

-- npm i -g pyright
require'lspconfig'.pyright.setup { on_attach = on_attach }
