local actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_ignore_patterns = { "^./.git/", "^node_modules/" },

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                    -- or right hand side can also be the name of the action as string
                    -- ["<c-d>"] = "delete_buffer",
                },
                n = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                }
            }
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")

local function search_dotfiles ()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.HOME .. "/.config/nvim",
        hidden = true,
    })
end

local function set_background(content)
    vim.fn.system(
        "feh --bg-scale "
            .. content
    )
end

local function select_background(prompt_bufnr, map)
    local function set_the_background(close)
        local content = require("telescope.actions.state").get_selected_entry()
        set_background(content.cwd .. "/" .. content.value)
        if close then
            require("telescope.actions").close(prompt_bufnr)
        end
    end

    map("i", "<C-p>", function()
        set_the_background()
    end)

    map("i", "<CR>", function()
        set_the_background(true)
    end)
end

local function image_selector(prompt, cwd)
    return function()
        telescope_builtin.find_files({
            prompt_title = prompt,
            cwd = cwd,
            previewer = false,

            attach_mappings = function(prompt_bufnr, map)
                select_background(prompt_bufnr, map)
                return true
            end,
        })
    end
end

local set_wallpaper = image_selector("< Wallpaper > ", "~/Pictures/Wallpapers")

local function git_branches ()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

SetKeymap("n", "<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>", { noremap = true })
SetKeymap("n", "<leader>pw", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand(\"<cword>\") }<CR>", { noremap = true })
SetKeymap("n", "<C-p>", telescope_builtin.git_files, { noremap = true })
SetKeymap("n", "<Leader>pf", telescope_builtin.find_files, { noremap = true })
SetKeymap("n", "<leader>pb", telescope_builtin.buffers, { noremap = true })
SetKeymap("n", "<leader>vh", telescope_builtin.help_tags, { noremap = true })
SetKeymap("n", "<leader>va", set_wallpaper, { noremap = true })
SetKeymap("n", "<leader>vd", search_dotfiles, { noremap = true })
SetKeymap("n", "<leader>gb", git_branches, { noremap = true })
