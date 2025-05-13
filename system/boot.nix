{pkgs, ...}: {
  boot.loader.systemd-boot.enable = pkgs.lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_cachyos;
}
