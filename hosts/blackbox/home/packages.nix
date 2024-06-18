{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../../packages/sekirofpsunlock.nix {})
  ];
}
