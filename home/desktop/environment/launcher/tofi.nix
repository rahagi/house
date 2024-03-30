{ pkgs, ... }:

{
  home.file = {
    "./config/tofi" = {
      source = ../../../../config/tofi;
      target = ".config/tofi";
      recursive = true;
    };
  };

  home.packages = [ pkgs.tofi ];
}
