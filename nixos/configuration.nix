# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, pkgs-unstable, config, system, colors, ... }:

let
  monitorsXml = builtins.readFile ./monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXml;
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.hyprland.enable = true;
  hardware.opengl.enable = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seyves = {
    isNormalUser = true;
    description = "seyves";
    extraGroups = [ "networkmanager" "wheel" "systemctl" ];
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # nvidia settings
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  # Enable the GNOME Desktop Environment.
  # Configure keymap in X1
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # Enable the X11 windowing system.
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openvpn.servers = {
      itoolabsVPN = {
        autoStart = false;
        config = "config /home/seyves/.config/openvpn/itoolabs/office.ovpn";
        updateResolvConf = true;
      };
    };
  };

  # environment.etc = {
  #   "NetworkManager/system-connections/office.nmconnection" = {
  #     text = ''
  #       [connection]
  #       id=ITooLabs
  #       uuid=074a03d0-69b7-4b65-8194-70ab9f3c9972
  #       type=vpn
  #
  #       [vpn]
  #       ca=/home/seyves/.config/openvpn/itoolabs/ca.crt
  #       cert=/home/seyves/.config/openvpn/itoolabs/user.crt
  #       cert-pass-flags=0
  #       challenge-response-flags=2
  #       comp-lzo=no-by-default
  #       compress=lz4
  #       connection-type=tls
  #       dev=tun
  #       key=/home/seyves/.config/openvpn/itoolabs/user.key
  #       remote=109.69.180.3:1194
  #       remote-cert-tls=server
  #       tls-crypt=/home/seyves/.config/openvpn/itoolabs/ta.key
  #       service-type=org.freedesktop.NetworkManager.openvpn
  #
  #       [ipv4]
  #       method=auto
  #
  #       [ipv6]
  #       addr-gen-mode=stable-privacy
  #       method=auto
  #
  #       [proxy]'';
  #     mode = "0600";
  #   };
  # };

  fonts.fontconfig.antialias = true;

  security.rtkit.enable = true;

  # Limit the number of generations to keep
  # boot.loader.systemd-boot.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libva-utils
    nvidia-vaapi-driver
    home-manager
    kitty
    git
    amnezia-vpn
  ];

  systemd.services.amnezia-vpn = {
    description = "Amnezia VPN Daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.amnezia-vpn}/bin/AmneziaVPN-service";
      Restart = "on-failure";
      User = "root"; # or root, if needed
    };
  };

  environment.sessionVariables = {
    TERM = "xterm-256color";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    # nvidia related
    LIBVA_DRIVER_NAME = "nvidia";
    # XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # QT_QPA_PLATFORM = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # WLR_DRM_NO_ATOMIC = "1";
    NVD_BACKEND = "direct";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # MOZ_ENABLE_WAYLAND = "1";
    # SDL_VIDEODRIVER = "wayland";
    # _JAVA_AWT_WM_NONREPARENTING = "1";
    # CLUTTER_BACKEND = "wayland";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  systemd.tmpfiles.rules =
    [ "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}" ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
      system = system;
      colors = colors;
      inherit inputs pkgs pkgs-unstable;
    };
    users = { "seyves" = import ../home-manager/home.nix; };
  };
}
