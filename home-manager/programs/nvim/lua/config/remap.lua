vim.g.mapleader = " "
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
vim.keymap.set("c", "<C-H>", "<C-W>", { desc = "Delete word" })
vim.keymap.set("n", "<C-d>", lazy("<C-d>zz"), { desc = "Centered C-d" })
vim.keymap.set("n", "<C-u>", lazy("<C-u>zz"), { desc = "Centered C-u" })
vim.keymap.set("n", "<C-w>s", ":split<CR><C-w>j", { desc = "Switch to splitted window on create" })
vim.keymap.set("n", "<C-w>v", ":vsplit<CR><C-w>l", { desc = "Switch to splitted window on create" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.o.guifont = "IosevkaTerm Nerd Font Mono:h13"
vim.g.neovide_background_color = "#ffffff"
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_cursor_trail_size = 0.3
vim.opt.guicursor = ""

--clipboard
vim.keymap.set("v", "<leader>y", '"+y', {desc = "Yank to clipboard"})
vim.keymap.set("v", "<leader>p", '"+p', {desc = "Paste from clipboard"})

-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")
