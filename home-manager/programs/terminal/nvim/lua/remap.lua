--utilities
local function lazy(keys)
    keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    return function()
        local old = vim.o.lazyredraw
        vim.o.lazyredraw = true
        vim.api.nvim_feedkeys(keys, 'nx', false)
        vim.o.lazyredraw = old
    end
end

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Visual mode drag bottom" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Visual mode drag top" })
vim.keymap.set("n", "[l", ':cp<CR>', { desc = "Quicklist Previous" })
vim.keymap.set("n", "]l", ':cn<CR>', { desc = "Quicklist Next" })
vim.keymap.set("n", "<C-d>", lazy("<C-d>zz"), { desc = "Centered C-d" })
vim.keymap.set("n", "<C-u>", lazy("<C-u>zz"), { desc = "Centered C-u" })
vim.keymap.set("n", "<C-w>s", ":split<CR><C-w>j", { desc = "Switch to splitted window on create" })
vim.keymap.set("n", "<C-w>v", ":vsplit<CR><C-w>l", { desc = "Switch to splitted window on create" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left pane" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom pane" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper pane" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right pane" })

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })

local insert_to_cursor = function(str)
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. str .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
end

vim.keymap.set("n", "<leader>pb", function()
    local current_buf_name = vim.api.nvim_buf_get_name(0)
    local cwd = vim.loop.cwd()
    local buf_path = "." .. string.sub(current_buf_name, string.len(cwd) + 1)
    insert_to_cursor(buf_path)
end, { desc = "Print path from cwd to buffer" })

vim.keymap.set("n", "<leader>pp", function()
    insert_to_cursor(vim.api.nvim_buf_get_name(0))
end, { desc = "Print full path" })
