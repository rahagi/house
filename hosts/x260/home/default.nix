{ config, ... }: {
  imports = [
    ../../../home
  ];
  
  config.desktopEnvironment.dwl = {
    someblocks.configFile = ../config/someblocks/blocks.h;
  };
}


