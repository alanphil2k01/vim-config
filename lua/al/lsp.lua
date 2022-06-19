-- lspconfig's server_configurations.md https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local cmp = require('cmp')
local lspkind = require('lspkind')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.opt.completeopt={ "menu", "menuone", "noselect" }
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

Set_keymap("n", "gd", vim.lsp.buf.definition)
Set_keymap("n", "gD", vim.lsp.buf.type_definition)
Set_keymap("n", "gi", vim.lsp.buf.implementation)
Set_keymap("n", "K", vim.lsp.buf.hover)
Set_keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
Set_keymap("n", "<leader>dv", vim.diagnostic.open_float)
Set_keymap("n", "<C-n>", vim.diagnostic.goto_next)
Set_keymap("n", "<leader>dp", vim.diagnostic.goto_prev)
Set_keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>")
Set_keymap("n", "<leader>ca", vim.lsp.buf.code_action)
Set_keymap("n", "<leader>rr", vim.lsp.buf.references)
Set_keymap("n", "<leader>rn", vim.lsp.buf.rename)
Set_keymap("n", "<leader>vh", vim.lsp.buf.signature_help)

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
		end,
	}, _config or {})
end

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<C-e>'] = cmp.mapping.abort(),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 4 },
    },
    formatting = {
        format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
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
require'lspconfig'.eslint.setup(config())

-- viml
require'lspconfig'.vimls.setup(config())

-- solidity-language-server
require'lspconfig'.solidity_ls.setup(config())

-- C/C++
require'lspconfig'.clangd.setup(config({
    cmd = {
        "clangd",
        "--enable-config",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu"
    },
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
local sumneko_root_path = os.getenv("HOME") .. '/Projects/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup(config({
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
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
