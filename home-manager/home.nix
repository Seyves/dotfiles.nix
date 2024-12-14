{ inputs, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./programs/terminal/tmux.nix
    ./programs/terminal/zsh.nix
    ./programs/terminal/nvim.nix
    ./programs/terminal/alacritty.nix
    ./programs/terminal/kitty.nix
    ./programs/ui/hyprland.nix
    inputs.ags.homeManagerModules.default
  ];

  services.gammastep = {
    temperature.night = 5000;
    # Can't find good location provider for geoclue2 :(
    latitude = 54.2;
    longitude = 37.61;
  };

  programs.ags = {
    enable = true;
    configDir = ../ags;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
  };

  # Allowing unfree
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  home = {
    username = "seyves";
    homeDirectory = "/home/seyves";
    stateVersion = "23.11";

    file."Pictures/frieren-sousou-no-frieren-4k-wal.jpg" = {
      enable = true;
      source = ./wallpapers/frieren-sousou-no-frieren-4k-wal.jpg;
    };
  };

  # Default mimetypes
  xdg.mimeApps = let
    mimetypes = {
      # images
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/jpg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/svg" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
      "image/heic" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      # audio 
      "audio/vnd.wave" = [ "org.gnome.Showtime.desktop" ];
      "audio/mpeg" = [ "org.gnome.Showtime.desktop" ];
      "audio/mid" = [ "org.gnome.Showtime.desktop" ];
      "audio/mp4" = [ "org.gnome.Showtime.desktop" ];
      # video 
      "video/mpeg" = [ "org.gnome.Showtime.desktop" ];
      "video/mp4" = [ "org.gnome.Showtime.desktop" ];
      "video/ogg" = [ "org.gnome.Showtime.desktop" ];
      "video/webm" = [ "org.gnome.Showtime.desktop" ];
      # text
      "text/markdown" = [ "neovide" ];
      "text/plain" = [ "neovide" ];
      "text/x-cmake" = [ "neovide" ];
      "application/json" = [ "neovide.desktop" ];
      "application/xhtml+xml" = [ "neovide.desktop" ];
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
      "application/x-msdownload" = [ "wine.desktop" ];
    };
  in {
    enable = true;
    associations.added = mimetypes;
    defaultApplications = mimetypes;
  };

  # Cursor theme
  home.pointerCursor = {
    x11.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 30;
    gtk.enable = true;
  };

  # QT theme
  qt = {
    enable = true;
    platformTheme.name = "kde";
  };
  # GTK theme
  gtk = {
    enable = true;
    font.name = "Roboto";

    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.papirus-icon-theme.override { color = "green"; });
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

  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    roboto
    inter

    # Tools for development
    bun
    go
    nodejs_20
    gcc
    rsync
    sshpass
    fzf
    pnpm
    ripgrep
    wine-wayland
    unzip

    # Desktop Apps
    firefox
    google-chrome
    slack
    nautilus
    file-roller
    loupe
    telegram-desktop
    postman
    insomnia
    neovide

    # Rising
    rofi-wayland
    swaybg
    libnotify
    waybar
    zsh-powerlevel10k
    wl-clipboard
    hyprpicker
    hyprshot
    swaynotificationcenter
    gammastep

    # Lsps
    bash-language-server
    typescript
    typescript-language-server
    vscode-langservers-extracted
    nodePackages.vls
    tailwindcss-language-server
    jsonnet-language-server
    lua-language-server
    gopls
    nil

    # Formatters
    sql-formatter
    prettierd
    sass
    eslint_d
    nixfmt-classic
  ]) ++ (with pkgs-unstable; [ showtime ]);
}
