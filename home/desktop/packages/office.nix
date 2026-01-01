{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    sc-im
    pandoc
    texlive.combined.scheme-medium
    foliate
    sweethome3d.application
    koodo-reader
  ];
}
