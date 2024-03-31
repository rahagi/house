{pkgs, ...}: {
  home.file.".cache/wallpaper.jpg".source = ../../../../wallpaper.jpg;
  xdg.configFile."wal" = {
    source = ../../../../config/wal;
    recursive = true;
  };

  home.packages = with pkgs; [pywal swaybg];
}
