return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git panel" })
        vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiff, { desc = "Git diff" })
        vim.keymap.set("n", "<leader>gb", function() vim.cmd('Git blame') end, { desc = "Git blame" })

        vim.keymap.set("n", "<leader>g[", "<cmd>diffget //2<CR>", { desc = "Apply left git merge" })
        vim.keymap.set("n", "<leader>g]", "<cmd>diffget //3<CR>", { desc = "Apply right git merge" })
    end
}
