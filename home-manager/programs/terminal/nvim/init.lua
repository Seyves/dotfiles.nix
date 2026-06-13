vim.wo.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.signcolumn = "yes"
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.g.neovide_padding_top = 38
vim.g.neovide_padding_bottom = 38
vim.g.neovide_padding_right = 40
vim.g.neovide_padding_left = 40
vim.opt.linespace = 6

vim.g.mapleader = " "

vim.o.guifont = "JetBrainsMono Nerd Font:h12"
vim.g.neovide_background_color = "#ffffff"
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_cursor_trail_size = 0.3
vim.opt.guicursor = ""

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', "javascript", "typescript", "lua", "vue" },
    callback = function() vim.treesitter.start() end,
})

require("remap")

-- Macros --
local leftKey = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
local escKey = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- go json tag --
vim.fn.setreg("j", "_yEA ``" .. leftKey .. "json:\"\"" .. escKey .. "hpF\"l~j_")
