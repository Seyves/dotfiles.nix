{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;

  mkBind = key: action: {
    _args = [
      key
      action
    ];
  };

  mkBindWith = key: action: options: {
    _args = [
      key
      action
      options
    ];
  };

  mkCurve = name: x1: y1: x2: y2: {
    _args = [
      name
      {
        type = "bezier";
        points = [
          [
            x1
            y1
          ]
          [
            x2
            y2
          ]
        ];
      }
    ];
  };

  mod = suffix: inline ''mainMod .. " + ${suffix}"'';
  exec = command: inline "hl.dsp.exec_cmd(${command})";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    submaps = {
      resize.settings = {
        bind = [
          (mkBind "escape" (inline ''hl.dsp.submap("reset")''))
          (mkBindWith "l" (inline "hl.dsp.window.resize({ x = 20, y = 0, relative = true })") {
            repeating = true;
          })
          (mkBindWith "h" (inline "hl.dsp.window.resize({ x = -20, y = 0, relative = true })") {
            repeating = true;
          })
          (mkBindWith "k" (inline "hl.dsp.window.resize({ x = 0, y = -20, relative = true })") {
            repeating = true;
          })
          (mkBindWith "j" (inline "hl.dsp.window.resize({ x = 0, y = 20, relative = true })") {
            repeating = true;
          })
        ];
      };
    };

    settings = {
      # Variables
      terminal = {
        _var = "kitty";
      };
      fileManager = {
        _var = "dolphin";
      };
      menu = {
        _var = "vicinae open";
      };
      screenShot = {
        _var = "hyprshot -m region --clipboard-only";
      };
      colorPicker = {
        _var = "hyprpicker -a";
      };
      mainMod = {
        _var = "SUPER";
      };

      # TODO
      # Make it work for all displays
      monitor = [
        {
          output = "DP-2";
          mode = "highres";
          position = "auto";
          scale = 2;
        }
        {
          output = "Unknown-1";
          disabled = true;
        }
      ];

      # Autostart
      on = {
        _args = [
          "hyprland.start"
          (inline ''
            function()
              hl.exec_cmd("swaybg -i ~/Pictures/wallpapers/wallpaper_6.jpg -m fill")
              hl.exec_cmd("ags")
              hl.exec_cmd("swaync")
              hl.exec_cmd("waybar")
              hl.exec_cmd("vicinae server")
              hl.exec_cmd("zen-beta", { workspace = "1 silent" })
              hl.exec_cmd(terminal, { workspace = "2 silent" })
              hl.exec_cmd("Telegram", { workspace = "4 silent" })
            end
          '')
        ];
      };

      config = {
        cursor = {
          no_hardware_cursors = true;
          enable_hyprcursor = false;
        };

        binds = {
          movefocus_cycles_fullscreen = true;
        };

        general = {
          gaps_in = 5;
          gaps_out = {
            top = 0;
            right = 15;
            bottom = 15;
            left = 15;
          };

          border_size = 0;

          col = {
            active_border = "rgb(202020)";
            inactive_border = "rgb(202020)";
          };

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "scrolling";
        };

        decoration = {
          rounding = 12;

          # Change transparency of focused and unfocused windows
          active_opacity = 1;
          inactive_opacity = 1;

          shadow = {
            enabled = true;
            range = 1;
            render_power = 3;
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            ignore_opacity = true;
            new_optimizations = true;
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = {
          force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        };

        input = {
          kb_layout = "us,ru";
          kb_model = "";
          kb_options = "grp:alt_shift_toggle";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = -0.2; # -1.0 - 1.0, 0 means no modification.
          accel_profile = "flat";

          touchpad = {
            natural_scroll = false;
          };
        };
      };

      curve = [
        (mkCurve "overshot" 0.05 0.9 0.1 1.05)
        (mkCurve "smoothOut" 0.36 0 0.66 (-0.56))
        (mkCurve "smoothIn" 0.25 1 0.5 1)
        (mkCurve "myBezier" 0.05 0.9 0.1 1.05)
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 3;
          bezier = "smoothIn";
          style = "popin 10%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 3;
          bezier = "smoothOut";
          style = "slide";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = false;
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3;
          bezier = "smoothIn";
          style = "popin 80%";
        }
      ];

      bind = [
        (mkBind (mod "F") (inline "hl.dsp.window.fullscreen()"))
        (mkBind (mod "T") (exec "terminal"))
        (mkBind (mod "Q") (inline "hl.dsp.window.close()"))
        (mkBind (mod "M") (inline "hl.dsp.exit()"))
        (mkBind (mod "E") (exec "fileManager"))
        (mkBind (mod "V") (inline ''hl.dsp.window.float({ action = "toggle" })''))
        (mkBind (mod "D") (exec "menu"))
        (mkBind (mod "P") (inline "hl.dsp.window.pseudo()"))
        (mkBind (mod "W") (inline ''hl.dsp.layout("togglesplit")''))
        # Colorpicker
        (mkBind (mod "C") (exec "colorPicker"))
        (mkBind "Print" (exec "screenShot"))
        # Move focus with mainMod + arrow keys
        (mkBind (mod "h") (inline ''hl.dsp.focus({ direction = "left" })''))
        (mkBind (mod "l") (inline ''hl.dsp.focus({ direction = "right" })''))
        (mkBind (mod "k") (inline ''hl.dsp.focus({ direction = "up" })''))
        (mkBind (mod "j") (inline ''hl.dsp.focus({ direction = "down" })''))
        # Switch workspaces with mainMod + [0-9]
        (mkBind (mod "1") (inline "hl.dsp.focus({ workspace = 1 })"))
        (mkBind (mod "2") (inline "hl.dsp.focus({ workspace = 2 })"))
        (mkBind (mod "3") (inline "hl.dsp.focus({ workspace = 3 })"))
        (mkBind (mod "4") (inline "hl.dsp.focus({ workspace = 4 })"))
        (mkBind (mod "5") (inline "hl.dsp.focus({ workspace = 5 })"))
        (mkBind (mod "6") (inline "hl.dsp.focus({ workspace = 6 })"))
        (mkBind (mod "7") (inline "hl.dsp.focus({ workspace = 7 })"))
        (mkBind (mod "8") (inline "hl.dsp.focus({ workspace = 8 })"))
        (mkBind (mod "9") (inline "hl.dsp.focus({ workspace = 9 })"))
        (mkBind (mod "0") (inline "hl.dsp.focus({ workspace = 10 })"))
        (mkBind (mod "ALT + 1") (inline "hl.dsp.window.move({ workspace = 1 })"))
        (mkBind (mod "ALT + 2") (inline "hl.dsp.window.move({ workspace = 2 })"))
        (mkBind (mod "ALT + 3") (inline "hl.dsp.window.move({ workspace = 3 })"))
        (mkBind (mod "ALT + 4") (inline "hl.dsp.window.move({ workspace = 4 })"))
        (mkBind (mod "ALT + 5") (inline "hl.dsp.window.move({ workspace = 5 })"))
        (mkBind (mod "ALT + 6") (inline "hl.dsp.window.move({ workspace = 6 })"))
        (mkBind (mod "ALT + 7") (inline "hl.dsp.window.move({ workspace = 7 })"))
        (mkBind (mod "ALT + 8") (inline "hl.dsp.window.move({ workspace = 8 })"))
        (mkBind (mod "ALT + 9") (inline "hl.dsp.window.move({ workspace = 9 })"))
        (mkBind (mod "ALT + 0") (inline "hl.dsp.window.move({ workspace = 10 })"))
        # Example special workspace (scratchpad)
        (mkBind (mod "S") (inline ''hl.dsp.workspace.toggle_special("magic")''))
        (mkBind (mod "ALT + S") (inline ''hl.dsp.window.move({ workspace = "special:magic" })''))
        # Move window
        (mkBind (mod "SHIFT + h") (inline ''hl.dsp.window.move({ direction = "left" })''))
        (mkBind (mod "SHIFT + l") (inline ''hl.dsp.window.move({ direction = "right" })''))
        (mkBind (mod "SHIFT + k") (inline ''hl.dsp.window.move({ direction = "up" })''))
        (mkBind (mod "SHIFT + j") (inline ''hl.dsp.window.move({ direction = "down" })''))
        (mkBind (mod "r") (inline ''hl.dsp.submap("resize")''))
        # Scroll through existing workspaces with mainMod + scroll
        (mkBind (mod "mouse_down") (inline ''hl.dsp.focus({ workspace = "e+1" })''))
        (mkBind (mod "mouse_up") (inline ''hl.dsp.focus({ workspace = "e-1" })''))
        # Move/resize windows with mainMod + LMB/RMB and dragging
        (mkBindWith (mod "mouse:272") (inline "hl.dsp.window.drag()") { mouse = true; })
        (mkBindWith (mod "mouse:273") (inline "hl.dsp.window.resize()") { mouse = true; })
      ];

      window_rule = [
        {
          match = {
            class = "^(org.telegram.desktop|telegramdesktop)$";
            title = "^(Media viewer)$";
          };
          float = true;
        }
        {
          match = {
            class = "(org.gnome.Loupe)";
          };
          float = true;
        }
        {
          match = {
            class = "(org.gnome.FileRoller)";
          };
          float = true;
        }
        {
          match = {
            class = "(org.gnome.Showtime)";
          };
          float = true;
        }
        {
          match = {
            title = "(AmneziaVPN)";
          };
          float = true;
        }
        {
          match = {
            title = "(linphone)";
          };
          float = true;
        }
        {
          match = {
            class = "(Better than Adventure! 7.2_01)";
          };
          rounding = 0;
        }
        {
          match = {
            title = "(Media viewer)";
          };
          maximize = true;
          no_anim = true;
        }
        {
          match = {
            class = "^(.*sway.*)$";
          };
          no_anim = true;
        }
        {
          match = {
            class = "(neovide)";
          };
          float = true;
          size = "1000 800";
        }
        {
          match = {
            class = "(twinkle)";
          };
          float = true;
        }
        {
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }
        {
          match = {
            class = "(org.pulseaudio.pavucontrol)";
          };
          float = true;
          size = "1000 800";
        }
        {
          match = {
            class = "(nm-connection-editor)";
          };
          float = true;
          size = "1000 800";
        }
      ];

      layer_rule = [
        {
          match = {
            namespace = "swaync-control-center";
          };
          blur = true;
        }
        {
          match = {
            namespace = "swaync-notification-window";
          };
          blur = true;
        }
        {
          match = {
            namespace = "vicinae";
          };
          blur = true;
        }
        {
          match = {
            namespace = "swaync-control-center";
          };
          ignore_alpha = 0;
        }
        {
          match = {
            namespace = "swaync-notification-window";
          };
          ignore_alpha = 0;
        }
        {
          match = {
            namespace = "swaync-notification-window";
          };
          no_anim = true;
        }
        {
          match = {
            namespace = "hyprpicker";
          };
          no_anim = true;
        }
        {
          match = {
            namespace = "selection";
          };
          no_anim = true;
        }
      ];
    };
  };
}
