local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Language features
  {
    "neovim/nvim-lspconfig",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "hrsh7th/nvim-cmp",
  },

  {
    "stevearc/conform.nvim",
  },

  {
    "mfussenegger/nvim-lint",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  {
    "mattn/emmet-vim",
  },

  -- Eyecandy
  {
    "goolord/alpha-nvim",
  },

  {
    "lewis6991/gitsigns.nvim",
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  {
    "nvim-lualine/lualine.nvim",
  },

  {
    "neanias/everforest-nvim",
    commit = "5493fc380cf871d6ee9395f2613e57006b2a1626",
    lazy = false,
    priority = 1000,
  },

  -- Navigation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Misc dependencies
  {
    "nvim-lua/plenary.nvim",
  },

  {
    "tpope/vim-fugitive",
  },

  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "mbbill/undotree",
  },

  {
    "folke/which-key.nvim",
  },

  {
    "numToStr/Comment.nvim",
  },

  {
    "L3MON4D3/LuaSnip",
  },

  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  },

}, {
  -- Lazy configuration
  defaults = {
    lazy = false,
  },

  install = {
    colorscheme = { "everforest" },
  },

  checker = {
    enabled = true,
    notify = false,
  },

  change_detection = {
    notify = false,
  },
})
