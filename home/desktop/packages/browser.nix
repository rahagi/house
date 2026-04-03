{pkgs, pkgs-stable, ...}: {
  home.packages = with pkgs; [pkgs-stable.brave firefox pkgs-stable.chromium];
}
