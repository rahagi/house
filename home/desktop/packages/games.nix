{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    steam
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
    protonplus
    gamescope
  ];
}
