{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamescope
    gamemode
    mangohud
    protontricks
    osu-lazer-bin
  ];
}
