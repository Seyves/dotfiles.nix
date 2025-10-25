require('treesitter-context').setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 3,
    trim_scope = 'inner',
    separator = "-"
})
