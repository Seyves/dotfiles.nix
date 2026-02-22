{ config, ... }: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      # ---------- General ----------
      modi = "drun,run,filebrowser,window";
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      show-icons = true;
      icon-theme = "Papirus";
      steal-focus = false;

      # ---------- Matching ----------
      matching = "normal";
      tokenize = true;

      # ---------- SSH ----------
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      # ---------- Drun ----------
      drun-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format =
        "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;

      # drun = {
      #   parse-user = true;
      #   parse-system = true;
      # };

      # ---------- Run ----------
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";

      # ---------- Fallback Icon ----------
      # "run,drun" = { fallback-icon = "application-x-addon"; };

      # ---------- Window Switcher ----------
      window-match-fields = "title,class,role,name,desktop";
      window-command = "wmctrl -i -R {window}";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;

      # ---------- History & Sorting ----------
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;

      # ---------- Display ----------
      display-window = "Windows";
      display-windowcd = "Window CD";
      display-run = "Run";
      display-ssh = "SSH";
      display-drun = "Apps";
      display-combi = "Combi";
      display-keys = "Keys";
      display-filebrowser = "Files";

      # ---------- Misc ----------
      terminal = "rofi-sensible-terminal";
      font = "Mono 12";
      sort = false;
      threads = 0;
      click-to-exit = true;

      # ---------- File Browser ----------
      # filebrowser = {
      #   directories-first = true;
      #   sorting-method = "name";
      # };

      # ---------- Timeout ----------
      # timeout = {
      #   action = "kb-cancel";
      #   delay = 0;
      # };
    };

    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      configuration = {
        modi = "drun,run,filebrowser,window";
        show-icons = true;
        display-drun = "";
        display-run = "";
        display-filebrowser = "";
        display-window = "";
        drun-display-format = "{name}";
        window-format = "{w}   {c}   {t}";
      };

      "*" = { font = "Inter 10"; };

      window = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        width = mkLiteral "800px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border-radius = mkLiteral "20px";
        cursor = "default";
        background-color = mkLiteral "rgba(22, 22, 22, 0.9)";
        border = 1;
        border-color = mkLiteral "rgba(40, 40, 40, 0.9)";
      };

      mainbox = {
        enabled = true;
        spacing = mkLiteral "25px";
        padding = mkLiteral "50px";
        background-color = mkLiteral "transparent";
        children =
          map mkLiteral [ "inputbar" "message" "listview" "mode-switcher" ];
      };

      inputbar = {
        enabled = true;
        spacing = mkLiteral "0px";
        margin = mkLiteral "0px 200px";
        padding = mkLiteral "5px";
        border = 1;
        border-radius = mkLiteral "100%";
        border-color = mkLiteral "gray/25%";
        background-color = mkLiteral "transparent";
        children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
      };

      textbox-prompt-colon = {
        enabled = true;
        expand = false;
        padding = mkLiteral "8px 11px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "#ece5d6";
        text-color = mkLiteral "black";
        str = "";
      };

      entry = {
        enabled = true;
        padding = mkLiteral "8px 12px";
        border = 0;
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#ece5d6";
        cursor = mkLiteral "text";
        placeholder = "Search...";
        placeholder-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      listview = {
        enabled = true;
        columns = 2;
        lines = 10;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;

        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        cursor = "default";
      };

      element = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px";
        border = 0;
        border-radius = mkLiteral "100%";
        border-color = mkLiteral "gray/15%";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#ece5d6";
        cursor = mkLiteral "pointer";
      };

      "element normal.active" = {
        background-color = mkLiteral "#aec080";
        text-color = mkLiteral "#161616";
      };

      "element selected.normal" = {
        background-color = mkLiteral "#aec080";
        text-color = mkLiteral "#161616";
      };

      "element selected.active" = {
        background-color = mkLiteral "#aec080";
        text-color = mkLiteral "#161616";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        size = 24;
        padding = mkLiteral "0px 0px 0px 10px";
        cursor = mkLiteral "inherit";
        text-color = mkLiteral "#161616";
      };

      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "mode-switcher" = {
        enabled = true;
        expand = false;
        spacing = mkLiteral "0px";
        margin = mkLiteral "0px 200px";
        padding = mkLiteral "12px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "rgba(40, 40, 40, 0.9)";
      };

      button = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#ece5d6";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#83b6af";
      };

      "error-message" = {
        padding = mkLiteral "20px";
        background-color = mkLiteral "#22272C";
        text-color = mkLiteral "#ece5d6";
      };

      message = {
        padding = mkLiteral "0px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#83b6af";
      };

      textbox = {
        padding = mkLiteral "0px";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
    };
  };
}
