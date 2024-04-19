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

  networking.hostName = "x260";
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
