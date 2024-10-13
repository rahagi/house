{
  pkgs,
  system,
  inputs,
  ...
}: {
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
    bun
    devenv
    postgresql
    openvpn
    httpie
    teleport
    mitmproxy
    httptoolkit
    inputs.nix-alien.packages.${system}.nix-alien
    localstack
    awscli2
  ];
}
