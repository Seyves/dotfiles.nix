# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, pkgs-unstable, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seyves = {
    isNormalUser = true;
    description = "seyves";
    extraGroups = [ "networkmanager" "wheel" "systemctl" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable the GNOME Desktop Environment.
  # Configure keymap in X1
  services = {
    xserver = {
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # Enable the X11 windowing system.
      enable = true;
      xkb = {
        layout = "us,ru";
        variant = "";
        options = "grp:alt_shift_toggle";
      };
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
      dummy = {
        autoStart = false;
        config = "config /home/seyves/.config/openvpn/dummy/office.ovpn";
        updateResolvConf = true;
      };
    };
  };

  environment.etc = {
    "NetworkManager/system-connections/office.nmconnection" = {
      text = ''
        [connection]
        id=ITooLabs
        uuid=074a03d0-69b7-4b65-8194-70ab9f3c9972
        type=vpn

        [vpn]
        ca=/home/seyves/.config/openvpn/itoolabs/ca.crt
        cert=/home/seyves/.config/openvpn/itoolabs/user.crt
        cert-pass-flags=0
        challenge-response-flags=2
        comp-lzo=no-by-default
        compress=lz4
        connection-type=tls
        dev=tun
        key=/home/seyves/.config/openvpn/itoolabs/user.key
        remote=213.248.35.133:1194, 109.69.180.3:1194
        remote-cert-tls=server
        tls-crypt=/home/seyves/.config/openvpn/itoolabs/ta.key
        service-type=org.freedesktop.NetworkManager.openvpn

        [ipv4]
        method=auto

        [ipv6]
        addr-gen-mode=stable-privacy
        method=auto

        [proxy]'';
      mode = "0600";
    };
    "NetworkManager/system-connections/dummy.nmconnection" = {
      text = ''
        [connection]
        id=Dummy
        uuid=022c3fd8-4922-4113-a6f2-d7f51175c02f
        type=vpn

        [vpn]
        ca=/home/seyves/.config/openvpn/dummy/ca.crt
        cert=/home/seyves/.config/openvpn/dummy/user.crt
        cert-pass-flags=0
        challenge-response-flags=2
        comp-lzo=no-by-default
        compress=lz4
        connection-type=tls
        dev=tun
        key=/home/seyves/.config/openvpn/dummy/user.key
        remote=213.248.35.133:1194, 109.69.180.3:1194
        remote-cert-tls=server
        tls-crypt=/home/seyves/.config/openvpn/dummy/ta.key
        service-type=org.freedesktop.NetworkManager.openvpn

        [ipv4]
        method=auto

        [ipv6]
        addr-gen-mode=stable-privacy
        method=auto

        [proxy]'';
      mode = "0600";
    };
  };

  fonts.fontconfig.antialias = true;

  security.rtkit.enable = true;

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

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
    kdePackages.wayland-protocols
    inputs.zen-browser.packages."x86_64-linux".default
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];
  environment.sessionVariables = {
    TERM = "xterm-256color";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    # nvidia related
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
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
  system.stateVersion = "24.05"; # Did you read the comment?

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs pkgs pkgs-unstable; };
    users = { "seyves" = import ../home-manager/home.nix; };
  };
}
