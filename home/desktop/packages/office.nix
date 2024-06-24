{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    sc-im
  ];
}
