-- Undotree
SetKeymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

-- File Explorer
SetKeymap("n", "<leader>e", ":Ex<CR>", { noremap = true })

SetKeymap("i", "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { silent = true, expr = true })
SetKeymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { noremap = true, silent = true })

SetKeymap("s","<Tab>", "<cmd>lua require('luasnip').jump(1)<Cr>", { noremap = true, silent = true })
SetKeymap("s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<Cr>", { noremap = true, silent = true })

SetKeymap("i", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true })
SetKeymap("s", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true })

SetKeymap("n", " Q", "<nop>", { noremap = true, silent = true })

-- For replacing all occurance of a word/patter
SetKeymap("n", "<leader>s", ":%s//g<Left><Left>", { noremap = true })

-- :so will source ~/.vimrc
SetKeymap("n", "<Leader><CR>", ":so ~/.config/nvim/init.lua<CR>", { noremap = true })
SetKeymap("n", "<Leader><Leader>", ":so %<CR>", { noremap = true })

-- Change between windows
SetKeymap("n", "<leader>h", ":wincmd h<CR>", {})
SetKeymap("n", "<leader>j", ":wincmd j<CR>", {})
SetKeymap("n", "<leader>k", ":wincmd k<CR>", {})
SetKeymap("n", "<leader>l", ":wincmd l<CR>", {})

-- terminal
SetKeymap("n", "<Leader>t", ":botright 12sp +terminal<CR> i", {})
SetKeymap("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
SetKeymap("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", { noremap = true })
SetKeymap("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", { noremap = true })
SetKeymap("t", "<Esc>q", "<C-\\><C-n>:q<CR>", { noremap = true })

-- Normalize
SetKeymap("v", "<leader>.", ":norm .<CR>", { noremap = true })

-- A blank line above current line
SetKeymap("n", "<leader>o", "o<Esc>k", {})

-- A blank line above current line
SetKeymap("n", "<leader>O", "O<Esc>j", {})

-- Move selection up or down
SetKeymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
SetKeymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- greatest remap ever
SetKeymap("v", "<leader>p", "\"_dP", { noremap = true })

-- Paste from clipboard
SetKeymap("n", "<leader>p", "\"+p", { noremap = true })

-- yank remaps
SetKeymap("n", "<leader>y", "\"+y", { noremap = true })
SetKeymap("v", "<leader>y", "\"+y", { noremap = true })
SetKeymap("n", "<leader>Y", "gg\"+yG", { noremap = true })
SetKeymap("n", "Y", "y$", { noremap = true })

-- delete to non-existance
SetKeymap("n", "<leader>d", "\"_d", { noremap = true })
SetKeymap("v", "<leader>d", "\"_d", { noremap = true })

-- make it executable
SetKeymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { noremap = true })

-- save as root
SetKeymap("n", "<leader>W", ":w !sudo tee %<CR>", { noremap = true })

-- run tmux-sessionizer
SetKeymap("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>", { noremap = true })

SetKeymap("i", "<C-c>", "<esc>", { noremap = true })
