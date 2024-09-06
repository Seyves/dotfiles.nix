{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    sensibleOnTop = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    historyLimit = 100000;
    plugins = with pkgs; [ tmuxPlugins.vim-tmux-navigator ];
    extraConfig = ''
      bind-key x kill-pane
      bind-key g choose-session
      bind-key s split-window -h 
      bind-key v split-window -v 
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g status-bg default
      set -g status-style bg=default
      set -g status-fg color15
      set-option -g window-status-current-format "#[fg=color9] #I:#W#{?window_zoomed_flag, 󰊓 , }"
      set-option -g status-right ""   
      setw -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';
  };
}
