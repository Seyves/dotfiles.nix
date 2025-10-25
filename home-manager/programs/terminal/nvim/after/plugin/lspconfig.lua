local lspconfig = require("lspconfig")

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function spread(template)
    local result = {}
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            spread(opts) { desc = "Go to definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end,
            spread(opts) { desc = "Hover documentation" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
            spread(opts) { desc = "Next diagnostic" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
            spread(opts) { desc = "Previous diagnostic" })
        vim.keymap.set({ "n", "v" }, "<leader>a", function() vim.lsp.buf.code_action() end,
            spread(opts) { desc = "Code actions" })
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
            spread(opts) { desc = "Quicklist references" })
        vim.keymap.set("n", "cn", function() vim.lsp.buf.rename() end, spread(opts) { desc = "Rename" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local language_servers = {
    nil_ls = {},
    bashls = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                },
            },
        },
    },
    gopls = {},
    html = {},
    cssls = {},
    tailwindcss = {},
    jsonls = {},
    jsonnet_ls = {},
    volar = {
        filetypes = { 'vue' },
        init_options = {
            vue = {
                hybridMode = false, -- don't use takeover mode for Vue 2
            },
        }
    }
}

require("typescript-tools").setup {}

for server, server_config in pairs(language_servers) do
    local config = { capabilities = capabilities }

    if server_config then
        for k, v in pairs(server_config) do
            config[k] = v
        end
    end

    lspconfig[server].setup(config)
end

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
        focusable = true,
    },
})
