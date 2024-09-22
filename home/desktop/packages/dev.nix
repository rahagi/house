{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    python3
    sops
    gitleaks
    postman
    mkcert
    nss
    android-tools
    dbeaver-bin
    wireguard-tools
    nodejs
    devenv
    postgresql
    openvpn
    httpie
    teleport
  ];
}
