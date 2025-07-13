{
  lib,
  pkgs ? import <nixpkgs> {},
}:
pkgs.python3Packages.buildPythonPackage {
  pname = "pywalfox";
  version = "2.8.0rc1";
  format = "setuptools";

  src = pkgs.fetchFromGitHub {
    owner = "Frewacom";
    repo = "pywalfox-native";
    rev = "7ecbbb193e6a7dab424bf3128adfa7e2d0fa6ff9";
    hash = "sha256-i1DgdYmNVvG+mZiFiBmVHsQnFvfDFOFTGf0GEy81lpE=";
  };
}
