{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs; [
    discord
    telegram-desktop
    discord-screenaudio
    legcord
    vesktop
    arrpc
    (chatterino2.overrideAttrs (old: rec {
      version = "2.5.3";
      src = fetchFromGitHub {
        owner = "Chatterino";
        repo = "chatterino2";
        tag = "v${version}";
        hash = "sha256-W2sqlqL6aa68aQ3nE161G64x7K7p8iByX03g1dseQbs=";
        fetchSubmodules = true;
      };
      buildInputs = (old.buildInputs or []) ++ [pkgs.libnotify pkgs.kdePackages.qtimageformats];
    }))
    thunderbird
  ];
  # ++ (with pkgs-stable; [chatterino2]);
}
