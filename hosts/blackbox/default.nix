{pkgs, ...}: {
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  networking.hostName = "blackbox";
  networking.firewall.enable = false;

  users.users.rhg.extraGroups = ["corectrl" "docker" "kvm"];

  boot.kernelParams = ["video=DP-3:1920x1080@165"];
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

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

  services.speechd.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  services.pcscd = {
    enable = true;
    plugins = [pkgs.acsccid];
  };
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.udev = {
    packages = with pkgs; [game-devices-udev-rules via qmk-udev-rules];
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", MODE="0666", GROUP="plugdev"
      ACTION=="add"|"remove", SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
      ACTION=="add"|"remove", SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
    '';
  };

  services.mullvad-vpn.enable = true;

  programs.droidcam.enable = true;

  programs.nix-ld.enable = true;

  programs.xwayland.enable = true;
}
