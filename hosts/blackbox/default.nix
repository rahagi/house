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

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = [pkgs.amdvlk];
    extraPackages32 = [pkgs.driversi686Linux.amdvlk];
  };
  # virtualisation: waydroid
  virtualisation.waydroid.enable = true;

  users.users.rhg.extraGroups = ["corectrl"];
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}
