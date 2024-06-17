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

  # virtualisation: waydroid
  virtualisation.waydroid.enable = true;
}
