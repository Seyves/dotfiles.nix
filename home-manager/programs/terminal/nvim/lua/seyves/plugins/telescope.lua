local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>sf', function() builtin.find_files({ no_ignore = true }) end,
    { desc = 'Search files' })
vim.keymap.set('n', '<leader>sw', builtin.live_grep, { desc = 'Search word' })
vim.keymap.set("n", "<leader>sw", telescope.extensions.live_grep_args.live_grep_args)
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sa', builtin.current_buffer_fuzzy_find,
    { desc = 'Search appearence in current file' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search buffers' })

--search and replace
local function open_search_and_replace_quickfix(bufnr)
    local current_picker = require('telescope.actions.state').get_current_picker(bufnr)
    local prompt = current_picker:_get_prompt()
    actions.send_to_qflist(bufnr)
    actions.open_qflist(bufnr)
    vim.api.nvim_feedkeys(":cdo s/" .. prompt .. "/", "n", true)
end

telescope.setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true,
            mappings = {
                i = {
                    ["<C-r>"] = open_search_and_replace_quickfix,
                    ["<C-Down>"] = actions.cycle_history_next,
                    ["<C-Up>"] = actions.cycle_history_prev,
                }
            }
        }
    },
    pickers = {
        live_grep = {
            mappings = {
                i = {
                    ["<C-r>"] = open_search_and_replace_quickfix,
                    ["<C-Down>"] = actions.cycle_history_next,
                    ["<C-Up>"] = actions.cycle_history_prev,
                }
            }
        },
        find_files = {
            hidden = true
        }
    },
    defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        preview = {
            -- Disable tree-sitter in telescope for performance
            treesitter = false
        }
    },
}

telescope.load_extension("live_grep_args")
