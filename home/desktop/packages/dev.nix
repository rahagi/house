{
  pkgs,
  pkgs-stable,
  system,
  inputs,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # programs.neovim = {
  #   enable = true;
  #   extraLuaPackages = ps: with ps; [magick];
  #   extraPython3Packages = ps:
  #     with ps; [
  #       ipython
  #       ipykernel
  #       pynvim
  #       jupyter-client
  #       cairosvg
  #       pnglatex
  #       plotly
  #       pyperclip
  #       nbformat
  #     ];
  # };

  home.packages = with pkgs;
    [
      python3
      sops
      gitleaks
      (postman.overrideAttrs (prev: rec {
        version = "11.77.2";
        src = fetchurl {
          url = "https://dl.pstmn.io/download/version/${version}/linux64";
          sha256 = "sha256-TPHPyv5Fx2BsN8sVUVFidkjukCacfafJ2tLJ0s4HlRk=";
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
      # mitmproxy
      httptoolkit
      # inputs.nix-alien.packages.${system}.nix-alien
      # localstack
      awscli2
      love
      cloc
      teleport
      zig
      zls
      hyx
      libgcc
      clang
      odin
      ols
      cloudflared
      tesseract
      cargo
      cargo-edit
      bubblewrap
      lua
      luajitPackages.luarocks
      python3Packages.jupytext
      libimobiledevice
      ruby
      podman-compose
      (pkgs.callPackage ../../../packages/bob-nvim.nix {})
    ]
    ++ [pkgs-stable.mitmproxy];
}
