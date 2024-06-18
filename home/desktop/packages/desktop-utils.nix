{pkgs, ...}: {
  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard
    libnotify
    ueberzugpp
    ffmpegthumbnailer
    imagemagick
    xdragon
    poppler_utils
    zathura
    pfetch-rs
    swappy
    sxiv
    swayidle
    swaylock
    chayang
    (pkgs.callPackage ../../../packages/pywalfox.nix {})
    wljoywake
  ];
}
