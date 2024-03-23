{ lib
, stdenv
, fetchFromSourcehut
, conf ? null
}:

let
  configFile = if lib.isDerivation conf || builtins.isPath conf then conf else "blocks.def.h";
in

stdenv.mkDerivation {
  pname = "someblocks";
  version = "master";

  src = fetchFromSourcehut {
    owner = "~raphi";
    repo = "someblocks";
    rev = "540a90e521e7c17c2010e038b934b73d2cf46df3";
    sha256 = "sha256-L+O6vq+cSPvxDDNiwNqRJCSrtsbiQ7SUw//HXkaZF88=";
  };

  outputs = [ "out" "man" ];

  prePatch = ''
    cp ${configFile} blocks.h
  '';

  makeFlags = [
    "PREFIX=$(out)"
    "MANPREFIX=$(man)/share/man"
  ];

  meta = with lib; {
    homepage = "https://git.sr.ht/~raphi/someblocks";
    description = "Modular status bar for somebar written in c.";
    license = licenses.isc;
    platforms = platforms.linux;
    mainProgram = "someblocks";
  };
}
