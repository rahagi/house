{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  appimageTools ? pkgs.appimageTools,
  fetchurl ? pkgs.fetchurl,
}: let
  pname = "osu-lazer-bin";
  version = "2024.1009.1";

  src = fetchurl {
    url = "https://github.com/ppy/osu/releases/download/${version}/osu.AppImage";
    hash = "sha256-2H2SPcUm/H/0D9BqBiTFvaCwd0c14/r+oWhyeZdNpoU=";
  };

  meta = {
    description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
    homepage = "https://osu.ppy.sh";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "osu!";
  };
in
  appimageTools.wrapType2 {
    inherit pname version src meta;

    extraPkgs = pkgs: with pkgs; [icu];

    extraInstallCommands = let
      contents = appimageTools.extract {inherit pname version src;};
    in ''
      mv -v $out/bin/${pname} $out/bin/osu\!
      install -m 444 -D ${contents}/osu\!.desktop -t $out/share/applications
      for i in 16 32 48 64 96 128 256 512 1024; do
        install -D ${contents}/osu\!.png $out/share/icons/hicolor/''${i}x$i/apps/osu\!.png
      done
    '';
  }
