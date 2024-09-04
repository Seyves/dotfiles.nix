{ pkgs, ... }: {
  imports = [
    ./programs/terminal/tmux.nix
    ./programs/terminal/zsh.nix
    ./programs/terminal/nvim.nix
    ./programs/terminal/alacritty.nix
  ];

  home = {
    username = "seyves";
    homeDirectory = "/home/seyves";
    stateVersion = "23.11";
    # using standard nvim config, because doing it through nix is too complex
  };

  nixpkgs.overlays = [
    (final: super: {
      rofi-wayland-unwrapped = super.rofi-wayland-unwrapped.overrideAttrs
        ({ patches ? [ ], ... }: {
          patches = patches ++ [
            (final.fetchpatch {
              url =
                "https://github.com/samueldr/rofi/commit/55425f72ff913eb72f5ba5f5d422b905d87577d0.patch";
              hash = "sha256-vTUxtJs4SuyPk0PgnGlDIe/GVm/w1qZirEhKdBp4bHI=";
            })
          ];
        });
    })
  ];

  fonts.fontconfig.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    roboto
    inter
    kde-rounded-corners
    nodejs_20
    zsh-powerlevel10k
    fzf
    nodePackages.pnpm
    rsync
    sshpass
    go
    telegram-desktop
    slack
    firefox
    google-chrome
    postman
    gcc
    ripgrep
    rofi-wayland
    # lsps
    nodePackages.bash-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.vue-language-server
    tailwindcss-language-server
    jsonnet-language-server
    lua-language-server
    gopls
    nil
    # formatters
    nodePackages.sql-formatter
    prettierd
    eslint_d
    nixfmt-classic
  ];
}
