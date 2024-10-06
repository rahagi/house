{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    sc-im
    pandoc
    texlive.combined.scheme-medium
    foliate
  ];
}
