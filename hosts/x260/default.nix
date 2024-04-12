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
}
