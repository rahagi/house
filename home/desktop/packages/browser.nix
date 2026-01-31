{pkgs, ...}: {
  home.packages = with pkgs; [brave firefox chromium];
}
