{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    telegram-desktop
    legcord
    vesktop
    arrpc
    chatterino2
    thunderbird
  ];
}
