vim.g.my_colorscheme = "kanagawa"

function ColorMyVim()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = 1
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.tokyonight_transparent = 1
    vim.g.tokyonight_dark_float = 1
    vim.opt.background = "dark"
    vim.g.gruvbox_invert_selection = '0'
    vim.g.tokyonight_colors = {
        hint= 'orange',
        error= '#ff0000',
    }

    vim.cmd("colorscheme " .. vim.g.my_colorscheme)

    local hl = function(highlight, opts)
        vim.api.nvim_set_hl(0, highlight, opts)
    end

    hl("ColorColumn", { ctermbg=0, bg = "grey" })
    hl("SignColumn", { bg = "None" })
    hl("CursorLineNR", { bg = "None" })
    hl("Normal", { bg = "None" })
    hl("netrwDir", { fg = "#5eacd3" })
    hl("LineNr", { bg = "None", fg = "#00bcff" })
    hl("LineNrAbove", { fg = "#8e8ca3" })
    hl("LineNrBelow", { fg = "#8e8ca3" })
    hl("netrwDir", { fg = "#5eacd3" })
    hl("qfFileName", { fg = "#aed75f" })
    hl("TelescopeNormal", { fg = "#ababab", bg = "None" })
    hl("TelescopeBorder", { fg = "#5eacd3", bg = "None" })
end

ColorMyVim()

SetKeymap("n", "<leader>cwm", ColorMyVim, { noremap = true })
SetKeymap("n", "<leader>vwm", ":let g:my_colorscheme = \"\"<Left>", { noremap = true })
