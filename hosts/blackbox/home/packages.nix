{pkgs, ...}: {
  xdg.configFile."kanshi" = {
    source = ../config/kanshi;
    recursive = true;
  };

  home.packages = [
    (pkgs.callPackage ../../../packages/sekirofpsunlock.nix {})
    pkgs.kanshi
  ];
}
