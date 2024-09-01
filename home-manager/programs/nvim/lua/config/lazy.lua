-- Loading lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({{import = "plugins"}, {import = "plugins.lsp"}}, {})

-- {
--     { 'numToStr/Comment.nvim', opts = {} },
--     { 'rose-pine/neovim',      as = 'rose-pine' },
--     'ggandor/leap.nvim',
--     'norcalli/nvim-colorizer.lua',
--
--     { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
--     --'nvim-treesitter/nvim-treesitter-context',
--
--     'ThePrimeagen/vim-be-good',
--     'nvim-lua/plenary.nvim',
--     'mattn/emmet-vim',
--     {
--         'goolord/alpha-nvim',
--         dependencies = {
--             'nvim-tree/nvim-web-devicons',
--             'nvim-lua/plenary.nvim'
--         },
--     },
--     'mbbill/undotree',
-- }
