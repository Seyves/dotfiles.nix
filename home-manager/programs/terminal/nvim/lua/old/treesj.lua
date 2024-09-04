return {
    'Wansmer/treesj',
    config = function()
        local tsj = require('treesj')

        tsj.setup({
            use_default_keymaps = false,
            ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
            ---@type boolean Node with syntax error will not be formatted
            check_syntax_error = true,
            ---If line after join will be longer than max value,
            ---@type number If line after join will be longer than max value, node will not be formatted
            max_join_length = 500,
            ---Cursor behavior:
            ---hold - cursor follows the node/place on which it was called
            ---start - cursor jumps to the first symbol of the node being formatted
            ---end - cursor jumps to the last symbol of the node being formatted
            ---@type 'hold'|'start'|'end'
            cursor_behavior = 'hold',
            ---@type boolean Notify about possible problems or not
            notify = true,
            ---@type boolean Use `dot` for repeat action
            dot_repeat = true,
            ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
            on_error = nil,
            ---@type table Presets for languages
            -- langs = {}, -- See the default presets in lua/treesj/langs
        })

        vim.keymap.set('n', '<leader>t', function()
            require('treesj').toggle({ split = { recursive = false } })
        end, { desc = "Tree" })
    end
}
