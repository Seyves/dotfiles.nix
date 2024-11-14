{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = { v = "nvim"; };
    autosuggestion.enable = true;
    plugins = [{
      name = "zsh-powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "./.p10k.zsh";
    }];
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" ];
      searchDownKey = [ "^[[B" ];
    };
    initExtra = builtins.readFile ./zshinit.sh;
  };
}
