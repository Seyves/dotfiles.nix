vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require('everforest').setup({
    -- transparent_background_level = 2,
    colours_override = function(palette)
        palette.bg_dim = "#1b1b1b"
        palette.bg0 = "#282828"
        palette.bg1 = "#32302f"
        palette.bg2 = "#32302f"
        palette.bg3 = "#45403d"
        palette.bg4 = "#45403d"
        palette.bg5 = "#5a524c"
    end,
    on_highlights = function(hl, palette)
        -- I like telescope that way :)
        hl.TelescopeBorder = { fg = palette.bg1, bg = palette.bg1 }
        hl.TelescopeNormal = { fg = palette.fg, bg = palette.bg1 }
        hl.TelescopeTitle = { fg = palette.purple }
        hl.TelescopePromptNormal = { fg = palette.fg, bg = palette.bg1 }
        hl.TelescopePromptBorder = { fg = palette.bg1, bg = palette.bg1 }
        -- More tweaks
        hl.InfoFloat = { bg = palette.bg0, fg = hl.InfoFloat.fg }
        hl.HintFloat = { bg = palette.bg0, fg = hl.HintFloat.fg }
        hl.ErrorFloat = { bg = palette.bg0, fg = hl.ErrorFloat.fg }
        hl.WarningFloat = { bg = palette.bg0, fg = hl.WarningFloat.fg }
        hl.FloatBorder = { bg = palette.bg0, fg = palette.bg5 }
        hl.NormalFloat = { bg = palette.bg0, fg = palette.fg }
        -- Leap highlights 
        hl.LeapMatch = { bg = palette.fb, fg = palette.bg0, bold = true }
        hl.LeapLabel = { bg = palette.red, fg = palette.bg0, bold = true }
    end,
})

local lualine_settings = {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        refresh = {
            statusline = 200,
        },
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        }
    }
}

vim.cmd.colorscheme("everforest")

local custom_lualine_theme = require 'lualine.themes.everforest'

custom_lualine_theme.normal.b.bg = "#282828"
custom_lualine_theme.normal.c.bg = "#282828"
custom_lualine_theme.insert.b.bg = "#282828"
custom_lualine_theme.insert.c.bg = "#282828"
custom_lualine_theme.visual.b.bg = "#282828"
custom_lualine_theme.visual.c.bg = "#282828"
custom_lualine_theme.command.b.bg = "#282828"
custom_lualine_theme.command.c.bg = "#282828"
custom_lualine_theme.inactive.b.bg = "#282828"
custom_lualine_theme.inactive.c.bg = "#282828"

lualine_settings.options.theme = custom_lualine_theme

require('lualine').setup(lualine_settings)

vim.cmd('hi! LineNr guibg=none ctermbg=none')
vim.cmd("highlight GitSignsAdd guibg=NONE")
vim.cmd("highlight GitSignsChange guibg=NONE")
vim.cmd("highlight GitSignsDelete guibg=NONE")
vim.cmd('highlight SignColumn guibg=NONE')
