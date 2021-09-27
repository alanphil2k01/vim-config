local function on_attach()
end

--[[
sudo pacman -S ccls

rustup +nightly component add rust-analyzer-preview

npm install -g typescript-language-server vim-language-server svelte-language-server pyright bash-language-server

git clone https://github.com/sumneko/lua-language-server ~/Projects/lsp/lua-language-server
cd ~/Projects/lsp/lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

GO111MODULE=on go get golang.org/x/tools/gopls@latest
]]

-- Ts/Js
require'lspconfig'.tsserver.setup{ on_attach=on_attach }

-- viml
require'lspconfig'.vimls.setup{ on_attach=on_attach }

-- C/C++
require'lspconfig'.ccls.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

-- Go
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

-- Rust
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

-- Lua
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local sumneko_root_path = '/home/alan/Projects/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
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


-- bash
require'lspconfig'.bashls.setup { on_attach = on_attach }

-- svelte
require'lspconfig'.svelte.setup { on_attach = on_attach }

-- python
require'lspconfig'.pyright.setup { on_attach = on_attach }
