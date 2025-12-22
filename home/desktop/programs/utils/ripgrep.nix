{pkgs, ...}: {
  xdg.configFile.".ripgreprc".source = ../../../../config/ripgrep/.ripgreprc;
  home.file.".rgignore".source = ../../../../config/ripgrep/.rgignore;

  home.packages = [pkgs.ripgrep];
}
