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
    outfox
    (pkgs.callPackage ../../../packages/osu-lazer-bin.nix {})
    hmcl
    heroic
    space-cadet-pinball
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    clonehero
  ];
}
