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
  networking.firewall.enable = false;

  users.users.rhg.extraGroups = ["corectrl" "docker"];

  boot.kernelParams = ["video=DP-3:1920x1080@165"];

  # hardware.graphics = {
  #   extraPackages = with pkgs; [mesa.drivers libvdpau-va-gl vaapiVdpau];
  #   extraPackages32 = with pkgs; [driversi686Linux.mesa.drivers];
  # };

  chaotic.mesa-git.enable = true;
  chaotic.hdr.enable = true;

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

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "10.3.0";
    };
    rocmOverrideGfx = "10.3.0";
  };
}
