{ config, lib, pkgs, ... }:
let
  fromGitHub = rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
  seyves-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "seyves-nvim";
    src = ./nvim;
  };
in {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # language features
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      conform-nvim
      nvim-lint
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      # eyecandy
      alpha-nvim
      gitsigns-nvim
      nvim-web-devicons
      lualine-nvim
      (fromGitHub "5493fc380cf871d6ee9395f2613e57006b2a1626" "main"
        "neanias/everforest-nvim")

      # navigation
      telescope-nvim
      telescope-live-grep-args-nvim
      oil-nvim
      harpoon
      leap-nvim
      vim-tmux-navigator

      plenary-nvim
      vim-fugitive
      treesj
      undotree
      which-key-nvim
      comment-nvim
      luasnip
      typescript-tools-nvim
      seyves-nvim
    ];
    extraLuaConfig = ''
      require("seyves")
    '';
  };
}
