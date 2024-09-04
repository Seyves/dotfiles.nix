local settings = {
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

return settings
