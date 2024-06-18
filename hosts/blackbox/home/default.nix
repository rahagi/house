{config, ...}: {
  imports = [
    ./packages.nix
    ../../../home
  ];

  config.desktopEnvironment.dwl = {
    yambar.configDir = ../config/yambar;
  };
}
