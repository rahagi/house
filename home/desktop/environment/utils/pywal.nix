{pkgs, ...}: {
  home.file = {
    "wallpaper.jpg" = {
      source = ../../../../wallpaper.jpg;
      target = ".cache/wallpaper.jpg";
    };
    "wal-config" = {
      source = ../../../../config/wal;
      target = ".config/wal";
      recursive = true;
    };
  };

  home.packages = with pkgs; [pywal swaybg];
}
