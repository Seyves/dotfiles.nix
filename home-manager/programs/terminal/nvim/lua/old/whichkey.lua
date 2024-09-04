return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>a", group = "[A]pply or [A]dd" },
            { "<leader>g", group = "[G]it" },
            { "<leader>h", group = "[H]arpoon" },
            { "<leader>q", group = "[Q]uicklist" },
            { "<leader>s", group = "[S]earch" },
        })
    end
}
