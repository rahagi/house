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
    (postman.overrideAttrs (prev: rec {
      version = "11.18.0";
      src = fetchurl {
        url = "https://dl.pstmn.io/download/version/${version}/linux64";
        sha256 = "sha256-f/GTghdOTntmcZHuzkZW17dQyaC9y6pcs1oDgUEbyLs=";
        name = "${prev.pname}-${version}.tar.gz";
      };
    }))
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
    mitmproxy
    httptoolkit
    inputs.nix-alien.packages.${system}.nix-alien
    # localstack
    awscli2
    love
    cloc
    teleport
    zig
    hyx
  ];
}
