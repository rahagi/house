{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  fetchgit ? pkgs.fetchgit,
}:
pkgs.stdenv.mkDerivation {
  pname = "dwlmsg";
  version = "master";

  src = fetchgit {
    url = "https://codeberg.org/notchoc/dwlmsg";
    rev = "edb673cb90a1236b53aebd9802523b7a5b4f7858";
    sha256 = "sha256-ZDz+cO6bGZjvusfWMiMBkmFEp45+vHOFfhcBFK0calQ=";
  };

  buildInputs = [
    pkgs.pkg-config
    pkgs.wayland
    pkgs.wayland-protocols
    pkgs.wayland-scanner
  ];

  patches = [../patches/dwlmsg/fix-urgent-state.patch];

  outputs = ["out"];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  meta = with lib; {
    homepage = "https://codeberg.org/notchoc/dwlmsg";
    description = "dwlmsg - send ipc messages to dwl";
    platforms = platforms.linux;
    mainProgram = "dwlmsg";
  };
}
