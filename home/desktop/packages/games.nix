{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamescope
    osu-lazer-bin
  ];
}
