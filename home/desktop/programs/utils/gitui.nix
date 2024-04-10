{pkgs, ...}: {
  xdg.configFile."gitui/key_bindings.ron".source = ../../../../config/gitui/key_bindings.ron;

  home.packages = [pkgs.gitui];
}
