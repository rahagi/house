{ lib
, pkgs
, stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation {
  pname = "kairaga";
  version = "3.3";
  
  src = fetchurl {
    url = "https://www.kairaga.com/download/kairaga-regular-unicode/?wpdmdl=4285&refresh=65f188402de231710327872";
    sha256 = "sha256-Xar24NJ+F/awYW62NCXvZthtWVAgxeJim1ns4eIb5xk=";
    name = "kairaga.zip";
  };

  buildInputs = [ pkgs.unzip ];

  phases = [ "installPhase" ];

  installPhase = ''
    unzip $src
    find . -name '*.otf' -exec install -Dm644 -t $out/share/fonts/opentype/ {} \;
  '';

  meta = with lib; {
    homepage = "https://kairaga.com";
    description = "";
    platforms = platforms.all;
  };
}
