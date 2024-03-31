{pkgs, ...}: {
  home.file = {
    ".config/easyeffects/output" = {
      source = ../../../config/easyeffects/output;
      target = ".config/easyeffects/output";
      recursive = true;
    };
  };

  services.easyeffects = {
    enable = true;
    preset = "HD 58X";
  };

  home.packages = with pkgs; [mpv];
}
