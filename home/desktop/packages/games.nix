{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamescope_git
    gamemode
    mangohud
    protontricks
    libstrangle
    wineWowPackages.staging
    winetricks
    (pkgs.callPackage ../../../packages/osu-lazer-bin.nix {})
  ];
}
