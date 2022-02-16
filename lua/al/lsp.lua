-- lspconfig's CONFIG.md https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local cmp = require'cmp'
local util = require'lspconfig.util'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}, _config or {})
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-space>"] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function(
                _ --[[fallback]]
                )
                if cmp.visible() then
                    if not cmp.confirm { select = true } then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        },
    },
    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 4 },
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    },
    formatting = {
        format = require'lspkind'.cmp_format {
            with_text = true,
            menu = {
                buffer = "[Buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                path = "[path]",
                luasnip = "[snip]",
                cmp_tabnine = "[TabNine]",
            },
        },
    }
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
})

-- Ts/Js
require'lspconfig'.tsserver.setup(config())

-- viml
require'lspconfig'.vimls.setup(config())

-- C/C++
require'lspconfig'.ccls.setup(config({
    root_dir = function() return vim.loop.cwd() end
}))

-- Go
require'lspconfig'.gopls.setup(config({
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}))

-- Rust
require'lspconfig'.rust_analyzer.setup(config())

-- Lua
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local sumneko_root_path = '/home/alan/Projects/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
require'lspconfig'.sumneko_lua.setup(config({
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
}))


-- bash
require'lspconfig'.bashls.setup (config())

-- svelte
require'lspconfig'.svelte.setup (config())

-- python
require'lspconfig'.pyright.setup (config())

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.config/nvim-plugins/plugged"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
