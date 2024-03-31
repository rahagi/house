{pkgs, ...}: {
  xdg.configFile."dunst" = {
    source = ../../../../config/dunst;
    recursive = true;
  };

  home.packages = [pkgs.dunst];
}
