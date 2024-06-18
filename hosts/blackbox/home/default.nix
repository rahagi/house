{config, ...}: {
  imports = [
    ../../../home
  ];

  config.desktopEnvironment.dwl = {
    yambar.configDir = ../config/yambar;
  };
}
