{config, ...}: {
  imports = [
    ./packages.nix
    ../../../home
  ];

  config.desktopEnvironment.hyprland = {
    enable = true;
  };
}
