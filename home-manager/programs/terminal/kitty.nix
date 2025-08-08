{ ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      adjust_line_height = "120%";
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;

      cursor_shape = "block";
      window_padding_width = 14;

      background = "#282828";
      foreground = "#d8caac";

      cursor = "#d8caac";

      selection_foreground = "#d8caac";
      selection_background = "#505a60";

      color0 = "#3c474d";
      color8 = "#868d80";

      # red
      color1 = "#e68183";
      # light red
      color9 = "#e68183";

      # green
      color2 = "#a7c080";
      # light green
      color10 = "#a7c080";

      # yellow
      color3 = "#d9bb80";
      # light yellow
      color11 = "#d9bb80";

      # blue
      color4 = "#83b6af";
      # light blue
      color12 = "#83b6af";

      # magenta
      color5 = "#d39bb6";
      # light magenta
      color13 = "#d39bb6";

      # cyan
      color6 = "#87c095";
      # light cyan
      color14 = "#87c095";

      # light gray
      color7 = "#868d80";
      # dark gray
      color15 = "#868d80";
    };
  };
}

