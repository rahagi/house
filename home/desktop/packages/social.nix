{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs;
    [discord telegram-desktop discord-screenaudio legcord vesktop arrpc]
    ++ (with pkgs-stable; [chatterino2]);
}
