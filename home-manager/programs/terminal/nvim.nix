{
  lib,
  pkgs,
  config,
  ...
}:
let
  fromGitHub =
    rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in
{
  # Just symlink it, so no build needed until no new dependencies
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/seyves/dotfiles.nix/home-manager/programs/terminal/nvim";

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    sideloadInitLua = true;
    plugins = with pkgs.vimPlugins; [
      # language features
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      conform-nvim
      nvim-lint
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      emmet-vim

      # eyecandy
      alpha-nvim
      gitsigns-nvim
      nvim-web-devicons
      lualine-nvim
      (fromGitHub "5493fc380cf871d6ee9395f2613e57006b2a1626" "main" "neanias/everforest-nvim")

      # navigation
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-live-grep-args-nvim
      oil-nvim
      harpoon

      # misc deps
      plenary-nvim
      vim-fugitive
      treesj
      undotree
      which-key-nvim
      comment-nvim
      luasnip
      typescript-tools-nvim
      tailwind-tools-nvim
    ];
  };
}
