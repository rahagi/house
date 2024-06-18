{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    bun
    gcc
    python3
    sops
    gitleaks
    postman
    mkcert
    nss
    android-tools
    dbeaver-bin
  ];
}
