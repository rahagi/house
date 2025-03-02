{pkgs, ...}: {
  home.packages = with pkgs; [brave firefox librewolf chromium];
}
