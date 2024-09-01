return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name)
                    return vim.startswith(name, ".")
                end,
            },
            use_default_keymaps = false,
            keymaps = {
                ["<CR>"] = "actions.select",
                ["-"] = "actions.parent",
            },
        })
        vim.keymap.set("n", "<leader>o", ":Oil<CR>", { desc = "Open filetree" })
    end
}
