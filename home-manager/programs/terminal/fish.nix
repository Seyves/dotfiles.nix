{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = { v = "nvim"; };
    shellAbbrs = {
      gcb = "fish -c 'git rev-parse --abbrev-ref HEAD'";
      gpo = "git push -u origin";
    };
    shellInit = ''
      ${builtins.readFile ./fishinit.fish}
    '';
  };
}
