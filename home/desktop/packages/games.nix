{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamescope_git
    gamemode
    mangohud
    protontricks
    osu-lazer-bin
    libstrangle
    wineWowPackages.staging
    winetricks
  ];
}
