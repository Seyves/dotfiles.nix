{ ... }:
{
  programs.vicinae = {
    enable = true;

    themes.kitty = {
      meta = {
        name = "Kitty";
        description = "My theme";
        variant = "dark";
        inherits = "vicinae-dark";
      };

      colors = {
        core = {
          accent = "#a7c080";
          accent_foreground = "#181818";
          background = "#181818";
          foreground = "#d8caac";
          secondary_background = "#181818";
          border = "#282828";
        };

        accents = {
          red = "#e68183";
          green = "#a7c080";
          yellow = "#d9bb80";
          blue = "#83b6af";
          magenta = "#d39bb6";
          cyan = "#87c095";
          orange = "#d9bb80";
          purple = "#d39bb6";
        };

        list = {
          item = {
            selection = {
              background = "#252A21";
              foreground = "#d8caac";
            };
          };
        };

        text = {
          muted = "#868d80";
          danger = "#e68183";
          success = "#a7c080";
          placeholder = "#868d80";
          selection = {
            background = "#505a60";
            foreground = "#d8caac";
          };
          links = {
            default = "#83b6af";
            visited = "#d39bb6";
          };
        };

        input = {
          border = "#505a60";
          border_focus = "#a7c080";
          border_error = "#e68183";
        };

        scrollbars.background = "#505a60";

        loading = {
          bar = "#a7c080";
          spinner = "#d8caac";
        };
      };
    };

    # "providers": {
    #    "browser-extension": {
    #       "enabled": false
    #    },
    #    "calculator": {
    #       "enabled": false
    #    },
    #    "clipboard": {
    #       "enabled": false
    #    },
    #    "core": {
    #       "enabled": false
    #    },
    #    "developer": {
    #       "enabled": false
    #    },
    #    "files": {
    #       "enabled": false
    #    },
    #    "font": {
    #       "enabled": false
    #    },
    #    "manage-shortcuts": {
    #       "enabled": false
    #    },
    #    "power": {
    #       "enabled": false
    #    },
    #    "raycast-compat": {
    #       "enabled": false
    #    },
    #    "scripts": {
    #       "enabled": false
    #    },
    #    "shortcuts": {
    #       "enabled": false
    #    },
    #    "snippets": {
    #       "enabled": false
    #    },
    #    "system": {
    #       "enabled": false
    #    },
    #    "theme": {
    #       "enabled": false
    #    },
    #    "wm": {
    #       "enabled": false
    #    }
    # }

    settings = {
      font = {
        normal = {
          family = "Inter";
          size = 10;
        };
      };
      providers = {
        browser-extension = {
          enabled = false;
        };
        core = {
          enabled = false;
        };
        developer = {
          enabled = false;
        };
        power = {
          enabled = false;
        };
        font = {
          enabled = false;
        };
        manage-shortcuts = {
          enabled = false;
        };
        raycast-compat = {
          enabled = false;
        };
        scripts = {
          enabled = false;
        };
        shortcuts = {
          enabled = false;
        };
        snippets = {
          enabled = false;
        };
        system = {
          enabled = false;
        };
        theme = {
          enabled = false;
        };
        wm = {
          enabled = false;
        };
      };

      theme.dark.name = "kitty";
      launcher_window.opacity = 0.90;
    };
  };
}
