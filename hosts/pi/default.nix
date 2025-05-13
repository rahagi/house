{pkgs, ...}: {
  imports = [
    ../../system/misc.nix
    ../../system/users.nix
    ../../system/security.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "pi";
  networking.firewall.enable = false;
  networking.networkmanager.enable = false;
  networking.wireless.enable = false;
  networking.useDHCP = true;

  users.users.rhg.extraGroups = ["docker" "kvm"];

  hardware.graphics = {
    enable = false;
  };
  hardware.enableAllFirmware = true;

  virtualisation.docker = {
    enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 2 * 1024;
    }
  ];

  system.stateVersion = "25.05";
}
