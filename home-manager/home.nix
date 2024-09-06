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

  xdg.mimeApps = let
    mimetypes = {
      # images
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/jpg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/svg" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
      # text
      "text/markdown" = [ "neovide" ];
      "text/plain" = [ "neovide" ];
      "text/x-cmake" = [ "neovide" ];
      # browser
      "text/html" = [ "zen.desktop" ];
      "x-scheme-handler/http=" = [ "zen.desktop" ];
      "x-scheme-handler/https=" = [ "zen.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" ];
      "x-scheme-handler/chrome" = [ "zen.desktop" ];
      "application/x-extension-htm" = [ "zen.desktop" ];
      "application/x-extension-html" = [ "zen.desktop" ];
      "application/x-extension-xml" = [ "zen.desktop" ];
      "application/x-extension-shtml" = [ "zen.desktop" ];
      "application/xhtml+xml" = [ "zen.desktop" ];
      "application/x-extension-xhtml" = [ "zen.desktop" ];
      "application/x-extension-xht" = [ "zen.desktop" ];
      # archiver
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-gtar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tarz" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zip-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar-compressed" = [ "org.gnome.FileRoller.desktop" ];
    };
  in {
    enable = true;
    associations.added = mimetypes;
    defaultApplications = mimetypes;
  };

  home.pointerCursor = {
    x11.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 30;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    font.name = "Roboto";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    cursorTheme = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

  };

  home.sessionVariables.GTK_THEME = "Colloid-Dark";

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
    swaybg
    eww
    waybar
    wine-wayland
    gnome.nautilus
    gnome.file-roller
    loupe
    neovide
    unzip
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
