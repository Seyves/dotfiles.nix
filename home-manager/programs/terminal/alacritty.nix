{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        offset = { y = 6; };
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 12;
      };

      window = {
        padding = {
          x = 40;
          y = 38;
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Always";
        };
        blink_interval = 500;
      };

      colors.primary = {
        background = "#282828";
        foreground = "#d3c6aa";
      };

      colors.normal = {
        black = "#475258";
        red = "#e67e80";
        green = "#a7c080";
        yellow = "#dbbc7f";
        blue = "#7fbbb3";
        magenta = "#d699b6";
        cyan = "#83c092";
        white = "#d3c6aa";
      };

      colors.bright = {
        black = "#475258";
        red = "#e67e80";
        green = "#a7c080";
        yellow = "#dbbc7f";
        blue = "#7fbbb3";
        magenta = "#d699b6";
        cyan = "#83c092";
        white = "#d3c6aa";
      };
    };
  };
}
