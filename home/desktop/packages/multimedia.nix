{pkgs, ...}: {
  xdg.configFile."easyeffects/output" = {
    source = ../../../config/easyeffects/output;
    recursive = true;
  };

  xdg.configFile."mpd" = {
    source = ../../../config/mpd;
    recursive = true;
  };

  xdg.configFile."ncmpcpp" = {
    source = ../../../config/ncmpcpp;
    recursive = true;
  };

  services.easyeffects = {
    enable = true;
    preset = "HD 58X";
  };

  home.packages = with pkgs; [mpv musescore pavucontrol mpd ncmpcpp mpc-cli];
}
