-- lspconfig's server_configurations.md https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local cmp = require('cmp')
local lspconfig = require('lspconfig')
local lspkind = require('lspkind')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.opt.completeopt={ "menu", "menuone", "noselect" }
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

SetKeymap("n", "gd", vim.lsp.buf.definition)
SetKeymap("n", "gD", vim.lsp.buf.type_definition)
SetKeymap("n", "gi", vim.lsp.buf.implementation)
SetKeymap("n", "K", vim.lsp.buf.hover)
SetKeymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
SetKeymap("n", "<leader>dv", vim.diagnostic.open_float)
SetKeymap("n", "<C-n>", vim.diagnostic.goto_next)
SetKeymap("n", "<leader>dp", vim.diagnostic.goto_prev)
SetKeymap("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>")
SetKeymap("n", "<leader>ca", vim.lsp.buf.code_action)
SetKeymap("n", "<leader>rr", vim.lsp.buf.references)
SetKeymap("n", "<leader>rn", vim.lsp.buf.rename)
SetKeymap("n", "<leader>vvh", vim.lsp.buf.signature_help)

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
lspconfig.tsserver.setup(config())
lspconfig.eslint.setup(config())

-- viml
lspconfig.vimls.setup(config())

-- solidity-language-server
-- lspconfig.solc.setup(config())
lspconfig.solidity.setup(config())

-- C/C++
-- lspconfig.ccls.setup {
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   }
-- }

lspconfig.clangd.setup(config({
    cmd = {
        "clangd",
        "--enable-config",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu"
    },
}))

-- Go
lspconfig.gopls.setup(config({
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
lspconfig.rust_analyzer.setup(config())

-- Lua
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local sumneko_root_path = os.getenv("HOME") .. '/Projects/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup(config({
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
lspconfig.bashls.setup (config())

-- svelte
lspconfig.svelte.setup (config())

-- python
lspconfig.pyright.setup (config())

-- tailwindcss
SetKeymap("n", "<Leader>,t", "<cmd>lua require'lspconfig'.tailwindcss.setup{}<CR>", { noremap = true})
