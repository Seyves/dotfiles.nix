{ config, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      autogenerated = 0;

      # TODO 
      # Make it work for all displays
      monitor = [ "DP-2,3840x2160@144,auto,2" "Unknown-1,disabled" ];

      # Autostart
      exec-once = [
        "swaybg -i ~/Pictures/frieren-sousou-no-frieren-4k-wal.jpg"
        "ags"
        "swaync"
      ];

      # Variables 
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show-icons -show drun";
      "$screenShot" = "hyprshot -m region --clipboard-only";
      "$colorPicker" = "hyprpicker -a";
      "$mainMod" = "ALT";

      env = [ "XCURSOR_THEME,Vanilla-DMZ" "XCURSOR_SIZE,30" ];

      # DANGEROUS
      # Remove this when nvidia will do better with electron apps
      debug = { damage_tracking = 0; };

      general = {
        gaps_in = 5;
        gaps_out = 30;

        border_size = 0;

        "col.active_border" = "rgba(a7c080ee) rgba(7fbbb3ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps;
        resize_on_border = true;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on;
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 15;

        # Change transparency of focused and unfocused windows
        active_opacity = 1;
        inactive_opacity = 1;

        drop_shadow = false;
        shadow_range = 1;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 30;
          passes = 2;

          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 3, smoothIn, popin 10%"
          "windowsOut, 1, 3, smoothOut, slide"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 4, overshot, "
        ];
      };

      dwindle = {
        pseudotile = true; # Master switch for pseudotiling.
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = { new_status = "master"; };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper =
          -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo =
          false; # If true disables the random hyprland logo / anime girl background. :(
      };

      input = {
        kb_layout = "us,ru";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = { natural_scroll = false; };
      };

      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager "
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, W, togglesplit, # dwindle"
        # Colorpicker
        "$mainMod, C, exec, $colorPicker "
        ", Print, exec, $screenShot"
        # Move focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Mouse rezise and move
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "float, class:(org.gnome.Loupe)"
        "float, class:(org.gnome.FileRoller)"
        "float, class:(org.gnome.Showtime)"
        "maximize, title:(Media viewer)"
        "noanim, title:(Media viewer)"
        "noanim, class:^(.*sway.*)$"
        "float, class:(neovide)"
        "suppressevent maximize, class:.* # You'll probably like this."
        "size 1000 800, class:(neovide)"
      ];

      layerrule = [ "noanim, swaync-notification-window" "noanim, rofi" ];
    };
  };
}
