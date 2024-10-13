{
  pkgs ? import <nixpkgs> {},
}:
pkgs.python3Packages.buildPythonPackage {
  name = "android-unpinner";
  version = "master";
  src = pkgs.fetchFromGitHub {
    owner = "mitmproxy";
    repo = "android-unpinner";
    rev = "2bc31d94c3fe296457e2d7bf2120220de16ca839";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  meta = {
    description = "Remove Certificate Pinning from APKs";
    homepage = "https://github.com/mitmproxy/android-unpinner";
  };
  doCheck = false;
}
