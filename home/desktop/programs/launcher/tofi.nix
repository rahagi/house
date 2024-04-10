{pkgs, ...}: {
  xdg.configFile."tofi" = {
    source = ../../../../config/tofi;
    recursive = true;
  };

  home.packages = [pkgs.tofi];
}
