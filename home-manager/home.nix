{ inputs, pkgs, system, ... }: {
  imports = [
    ./programs/terminal/tmux.nix
    ./programs/terminal/nvim.nix
    ./programs/terminal/kitty.nix
    ./programs/terminal/fish.nix
    ./programs/ui/hyprland.nix
    inputs.zen-browser.homeModules.beta
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  services.gammastep = {
    temperature.night = 5000;
    # Can't find good location provider for geoclue2 :(
    latitude = 54.2;
    longitude = 37.61;
  };

  # Zen browser
  programs.zen-browser.enable = true;

  # Allowing unfree
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  home = {
    username = "seyves";
    homeDirectory = "/home/seyves";
    stateVersion = "25.05";

    pointerCursor = {
      x11.enable = true;
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
      gtk.enable = true;
      hyprcursor.size = 32;
    };

    file."Pictures/wallpapers" = {
      enable = true;
      source = ./wallpapers;
    };
  };

  # Default mimetypes
  xdg.mimeApps = let
    value = let zen-browser = inputs.zen-browser.packages.${system}.beta;
    in zen-browser.meta.desktopFileName;

    zenMimetypes = builtins.listToAttrs (map (name: { inherit name value; }) [
      "application/x-extension-shtml"
      "application/x-extension-xhtml"
      "application/x-extension-html"
      "application/x-extension-xht"
      "application/x-extension-htm"
      "x-scheme-handler/unknown"
      "x-scheme-handler/mailto"
      "x-scheme-handler/chrome"
      "x-scheme-handler/about"
      "x-scheme-handler/https"
      "x-scheme-handler/http"
      "application/xhtml+xml"
      "application/json"
      "application/pdf"
      "text/html"
    ]);

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
      # "text/html" = [ "zen.desktop" ];
      # "x-scheme-handler/http=" = [ "zen.desktop" ];
      # "x-scheme-handler/https=" = [ "zen.desktop" ];
      # "x-scheme-handler/http" = [ "zen.desktop" ];
      # "x-scheme-handler/https" = [ "zen.desktop" ];
      # "x-scheme-handler/chrome" = [ "zen.desktop" ];
      # "application/x-extension-htm" = [ "zen.desktop" ];
      # "application/x-extension-html" = [ "zen.desktop" ];
      # "application/x-extension-xml" = [ "zen.desktop" ];
      # "application/x-extension-shtml" = [ "zen.desktop" ];
      # "application/x-extension-xhtml" = [ "zen.desktop" ];
      # "application/x-extension-xht" = [ "zen.desktop" ];
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
    associations.added = mimetypes // zenMimetypes;
    defaultApplications = mimetypes // zenMimetypes;
  };

  # Cursor theme
  # QT theme
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.colloid-kde;
      name = "gtk2";
    };
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
      size = 32;
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
    nerd-fonts.jetbrains-mono
    roboto
    inter
    fish

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
    wine
    twinkle
    unzip
    jq
    docker
    htop-vim
    keychain

    # Desktop Apps
    pavucontrol
    libreoffice
    networkmanagerapplet
    google-chrome
    slack
    nautilus
    file-roller
    loupe
    telegram-desktop
    postman
    insomnia
    neovide
    obsidian
    showtime
    eyedropper
    gimp

    # Rising
    # zsh-powerlevel10k
    # swww
    rofi-wayland
    swaybg
    libnotify
    waybar
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
    tailwindcss-language-server
    jsonnet-language-server
    lua-language-server
    gopls
    nil
    vue-language-server

    # Formatters
    sql-formatter
    prettierd
    sass
    eslint_d
    nixfmt-classic
  ]);
}
