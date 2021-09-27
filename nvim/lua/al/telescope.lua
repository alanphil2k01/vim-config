local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

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

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
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
        local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
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
        require("telescope.builtin").find_files({
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

local function set_theme(theme_dir, content)
    local curr_theme = theme_dir.. "/init.lua"
    local new_theme = theme_dir.. "/" .. content
    vim.fn.system(
        "cp " .. new_theme .. " " .. curr_theme
    )
    vim.fn.system(
        "awesome-client 'awesome.restart()'"
    )
end

local function select_theme(prompt_bufnr, map)
    local function set_the_theme(close)
        local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
        set_theme(content.cwd, content.value)
        if close then
            require("telescope.actions").close(prompt_bufnr)
        end
    end

    map("i", "<C-p>", function()
        set_the_theme()
    end)

    map("i", "<CR>", function()
        set_the_theme(true)
    end)
end

local function theme_selector(prompt, cwd)

    local find_themes ={ "fd", "lua", "-E=init.lua" }
    -- local find_themes ={ "find", ".", "-path './*.lua'"}
    return function()
        require("telescope.builtin").find_files({
            prompt_title = prompt,
            cwd = cwd,
            find_command = find_themes,
            previewer = false,

            attach_mappings = function(prompt_bufnr, map)
                select_theme(prompt_bufnr, map)
                return true
            end,
        })
    end
end

M.wallpaper = image_selector("< Wallpaper > ", "~/Pictures/Wallpapers")

M.theme = theme_selector("< theme > ", "~/.config/awesome/theme")

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

return M
