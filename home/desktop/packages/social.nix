{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    telegram-desktop
    discord-screenaudio
    legcord
    vesktop
    arrpc
    chatterino2
    thunderbird
  ];
}
