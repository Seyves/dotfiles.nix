{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = { v = "nvim"; };
    autosuggestion.enable = true;
    plugins = [{
      name = "zsh-powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" ];
      searchDownKey = [ "^[[B" ];
    };
    initExtraFirst = builtins.readFile ./.p10k.zsh;
    initExtra = builtins.readFile ./zshinit.sh;
  };
}
