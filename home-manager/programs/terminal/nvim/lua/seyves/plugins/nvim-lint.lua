local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
    vue = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local enabled = false

local toggle_lint = function()
    if enabled == true then
        enabled = false
        vim.diagnostic.reset(nil, 0)
    else
        enabled = true
        require("lint").try_lint()
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        if enabled == true then
            lint.try_lint()
        end
    end,
})

vim.keymap.set({ "n" }, "<leader>l", toggle_lint, { noremap = true, desc = "Lint" })
