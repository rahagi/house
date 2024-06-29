{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamescope
    gamemode
    mangohud
    osu-lazer-bin
  ];
}
