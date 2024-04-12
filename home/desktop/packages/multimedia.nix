{pkgs, ...}: {
  xdg.configFile."easyeffects/output" = {
    source = ../../../config/easyeffects/output;
    recursive = true;
  };

  services.easyeffects = {
    enable = true;
    preset = "HD 58X";
  };

  home.packages = with pkgs; [mpv musescore pavucontrol];
}
