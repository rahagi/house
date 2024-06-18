{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenvNoCC ? pkgs.stdenvNoCC,
  fetchurl ? pkgs.fetchurl,
}: let
  version = "0.2.3";
  fname = "sekirofpsunlock-v${version}-x86_64-musl.tar.gz";
in
  stdenvNoCC.mkDerivation {
    pname = "sekirofpsunlock";
    version = version;

    src = fetchurl {
      url = "https://github.com/Lahvuun/sekirofpsunlock/releases/download/v${version}/sekirofpsunlock-v${version}-x86_64-musl.tar.gz";
      sha256 = "sha256-BReGWCAMx8ZqURh6JdjEtpksA8KpCMwAi11LSjPAiBY=";
      name = fname;
    };

    phases = ["installPhase"];

    installPhase = ''
      tar -xvf $src
      mkdir -p $out/bin
      install -Dm755 sekirofpsunlock $out/bin/;
    '';

    meta = with lib; {
      homepage = "https://github.com/Lahvuun/sekirofpsunlock";
      description = "Patch Sekiro under Linux";
      platforms = platforms.linux;
      license = licenses.mit;
    };
  }
