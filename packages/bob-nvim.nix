{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenvNoCC ? pkgs.stdenvNoCC,
  fetchurl ? pkgs.fetchurl,
}: let
  version = "v4.1.4";
  fname = "bob-linux-x86_64.zip";
in
  stdenvNoCC.mkDerivation {
    pname = "bob-nvim";
    version = version;

    buildInputs = [pkgs.unzip];

    src = fetchurl {
      url = "https://github.com/MordechaiHadad/bob/releases/download/${version}/bob-linux-x86_64.zip";
      sha256 = "sha256-+EUjFgEzXFT7lJttStDTjC5QSAf3JM3znz+jI6GzcCw=";
      name = fname;
    };

    phases = ["installPhase"];

    installPhase = ''
      unzip $src
      mkdir -p $out/bin
      find . -name 'bob' -exec install -Dm755 -t $out/bin/ {} \;
    '';

    meta = with lib; {
      homepage = "https://github.com/MordechaiHadad/bob";
      description = "A version manager for neovim";
      platforms = platforms.linux;
      license = licenses.mit;
    };
  }
