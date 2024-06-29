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

  hardware.graphics = {
    extraPackages = with pkgs; [mesa.drivers libvdpau-va-gl vaapiVdpau];
    extraPackages32 = [pkgs.driversi686Linux.mesa.drivers];
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
