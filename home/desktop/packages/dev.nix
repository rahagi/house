{pkgs, ...}: {
  home.packages = with pkgs; [
    bun
    gcc
    python3
    sops
    gitleaks
    postman
    android-tools
  ];
}
