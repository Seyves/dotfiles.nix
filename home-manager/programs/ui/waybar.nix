{ config, pkgs-unstable, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      reload_style_on_change = true;
      layer = "top";
      position = "top";
      include = [ "~/.config/waybar/modules.json" ];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
          empty = "";
        };
        persistent-workspaces = { "*" = [ 1 2 3 4 5 ]; };
      };

      "clock#date" = {
        tooltip = false;
        format = "   {:%A; %b %d }";
        interval = 1;
      };
      "clock#time" = {
        tooltip = false;
        format = "- {:%H:%M}";
        interval = 1;
      };

      network = {
        format-wifi = "󰤢";
        format-ethernet = "";
        format-disconnected = "󰤠";
        interval = 5;
        tooltip-format = "{essid} ({signalStrength}%)";
        on-click = "nm-connection-editor";

      };

      cpu = {
        interval = 1;
        format = "";
        on-click = "kitty -e htop";
      };

      memory = {
        interval = 30;
        format = "  {used:0.1f}G/{total:0.1f}G";
        tooltip-format = "Memory";
      };

      "custom/uptime" = {
        format = "{}";
        format-icon = [ "" ];
        tooltip = false;
        interval = 1600;
        exec = "$HOME/.config/waybar/scripts/uptime.sh";
      };

      "custom/notification" = {
        tooltip = true;
        format = "{icon}";
        format-icons = {
          notification = "󱅫";
          none = "󰂚";
          dnd-notification = "󰂛";
          dnd-none = "󰂛";
          inhibited-notification = "󱅫";
          inhibited-none = "󰂚";
          dnd-inhibited-notification = "󰂛";
          dnd-inhibited-none = "󰂛";
        };
        tooltip-format = "Notifications";
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      bluetooth = {
        format = "󰂲";
        format-on = "{icon}";
        format-off = "{icon}";
        format-connected = "{icon}";
        format-icons = {
          on = "󰂯";
          off = "󰂲";
          connected = "󰂱";
        };
        on-click = "blueman-manager";
        tooltip-format-connected = "{device_enumerate}";
      };

      pulseaudio = {
        format = "{icon}";
        format-muted = "";
        format-icons = { "default" = [ "" "" "" ]; };
        on-click = "pavucontrol";
      };

      modules-left = [ "clock#date" "clock#time" ];

      modules-center = [ "hyprland/workspaces" ];

      modules-right = [ "cpu" "pulseaudio" "network" "custom/notification" ];
    };
  };
}
