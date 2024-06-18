{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  networking.hostName = "blackbox";

  users.users.rhg.extraGroups = ["corectrl" "docker"];

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = [pkgs.amdvlk];
    extraPackages32 = [pkgs.driversi686Linux.amdvlk];
  };

  # virtualisation: waydroid
  virtualisation.waydroid.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}
