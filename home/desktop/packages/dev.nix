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

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: with ps; [magick];
    extraPython3Packages = ps:
      with ps; [
        ipython
        ipykernel
        pynvim
        jupyter-client
        cairosvg
        pnglatex
        plotly
        pyperclip
        nbformat
      ];
  };

  home.packages = with pkgs;
    [
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
      (hoppscotch.overrideAttrs (prev: rec {
        version = "25.2.1-0";
        src =
          fetchurl
          {
            aarch64-darwin = {
              url = "https://github.com/hoppscotch/releases/releases/download/v${version}/Hoppscotch_mac_aarch64.dmg";
              hash = "sha256-1KYc96WUlybXhgPeT97w1mLE2zxmohIhvNMCmEb5Vf0=";
            };
            x86_64-darwin = {
              url = "https://github.com/hoppscotch/releases/releases/download/v${version}/Hoppscotch_mac_x64.dmg";
              hash = "sha256-wdqgzTXFL7Dvq1DOrjyPE4O3OYfpvmRSLzk+HBJIaTU=";
            };
            x86_64-linux = {
              url = "https://github.com/hoppscotch/releases/releases/download/v${version}/Hoppscotch_linux_x64.AppImage";
              hash = "sha256-Rpyr7dHTSCqquiN/Z2stdtWBo6AJ1gSEs+RBJx70eLM=";
            };
          }
          .${stdenv.system}
          or (throw "Unsupported system: ${stdenv.system}");
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
      inputs.nix-alien.packages.${system}.nix-alien
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
      android-studio
      lua
      luajitPackages.luarocks
      python3Packages.jupytext
      libimobiledevice
    ]
    ++ [pkgs-stable.mitmproxy];
}
