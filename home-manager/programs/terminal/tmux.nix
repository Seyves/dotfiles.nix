{ pkgs, ... }: {
  home.file.".config/tmux/tmux-session-dispensary.sh" = {
    enable = true;
    source = ./tmux-session-dispensary.sh;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-s";
    sensibleOnTop = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    baseIndex = 1;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    historyLimit = 100000;
    extraConfig = ''
      bind-key x kill-pane
      bind-key g choose-session
      bind-key v split-window -h 
      bind-key s split-window -v 
      set -a terminal-features "screen-256color:RGB"
      set -g status-bg default
      set -g renumber-windows on
      set -g status-style bg=default
      set -g status-fg color15
      set-option -g window-status-current-format "#[fg=color9] #I:#W#{?window_zoomed_flag, 󰊓 , }"
      set-option -g status-right ""   
      setw -g mode-keys vi
      set -sg escape-time 10
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      bind S run-shell "tmux neww ~/.config/tmux/tmux-session-dispensary.sh"
    '';
  };
}
