{ pkgs, ... }:

{
  home.file = {
    "./config/dunst" = {
      source = ../../../../config/dunst;
      target = ".config/dunst";
      recursive = true;
    };
  };

  home.packages = [ pkgs.dunst ];
}
