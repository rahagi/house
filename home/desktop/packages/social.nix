{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    telegram-desktop
    legcord
    chatterino2
    thunderbird
  ];
}
