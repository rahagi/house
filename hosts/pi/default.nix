{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    ../../system/misc.nix
    ../../system/users.nix
    ../../system/security.nix
    inputs.sops-nix.nixosModules.sops
  ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "pi";
  networking.firewall.enable = false;
  networking.wireless.enable = false;

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

  # # setup zeronsd
  # environment.systemPackages = [pkgs-stable.zeronsd];
  # sops.secrets.zerotier-api-key = {};
  # systemd.services.zeronsd = {
  #   description = "Provision zeronsd service";
  #   requires = ["zerotierone.service"];
  #   wants = ["network-online.target"];
  #   after = ["network-online.target"];
  #   wantedBy = ["multi-user.target"];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = pkgs.lib.mkForce ''
  #       /bin/sh -c "${pkgs-stable.zeronsd}"/bin/zeronsd \
  #         start \
  #         -t /run/secrets/zerotier-api-key \
  #         -w \
  #         -d u.wu \
  #         $(cat /run/secrets/zerotier-network-id)
  #     '';
  #     TimeoutStopSec = 30;
  #     Restart = "always";
  #     User = "root";
  #   };
  # };

  system.stateVersion = "25.05";
}
