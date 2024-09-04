local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettierd" },
        html = { "prettierd"},
        go = { "crlfmt" },
        css = { "prettierd" },
        sql = { "sql-formatter" },
        scss = { "prettierd" },
        nix = { "nixfmt" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format" })
