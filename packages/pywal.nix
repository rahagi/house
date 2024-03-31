{
  lib,
  pkgs ? import <nixpkgs> {},
}:
pkgs.python3Packages.buildPythonPackage {
  name = "pywal";
  version = "master";
  src = pkgs.fetchFromGitHub {
    owner = "dylanaraps";
    repo = "pywal";
    rev = "236aa48e741ff8d65c4c3826db2813bf2ee6f352";
    hash = "sha256-La6ErjbGcUbk0D2G1eriu02xei3Ki9bjNme44g4jAF0=";
  };
  meta = {
    description = "Generate and change colorschemes on the fly. A 'wal' rewrite in Python 3";
    homepage = "https://github.com/dylanaraps/pywal";
    license = lib.licenses.mit;
  };
  doCheck = false;
}
