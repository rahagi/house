{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  networking.hostName = "blackbox";
  networking.firewall.enable = false;

  users.users.rhg.extraGroups = [
    "corectrl"
    "podman"
    "kvm"
    "vboxusers"
    "gamemode"
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = ["video=DP-3:1920x1080@165"];
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  boot.binfmt.preferStaticEmulators = true;

  # virtualisation: waydroid
  virtualisation.waydroid.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  # virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
  users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];

  hardware.amdgpu.overdrive = {
    enable = true;
    ppfeaturemask = "0xffffffff";
  };
  programs.corectrl.enable = true;

  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   environmentVariables = {
  #     HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  #   };
  #   rocmOverrideGfx = "10.3.0";
  # };

  services.speechd.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  services.pcscd = {
    enable = true;
    plugins = [pkgs-stable.acsccid];
  };
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.udev = {
    packages = with pkgs; [
      game-devices-udev-rules
      via
      qmk-udev-rules
    ];
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0111", ENV{ID_INPUT_JOYSTICK}=""
      ACTION=="add",    SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
      ACTION=="remove", SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
      ACTION=="add",    SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
      ACTION=="remove", SUBSYSTEM=="net", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", ENV{ID_USB_DRIVER}=="rndist_host", SYMLINK+="android"
    '';
  };

  services.mullvad-vpn.enable = true;

  services.netbird.useRoutingFeatures = "both";
  services.netbird.clients.wt0 = {
    port = 51821;
    ui.enable = true;
    openFirewall = true;
    openInternalFirewall = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Virtual Display";
          prep-cmd = [
            {
              do = "sudo -E -u rhg sh -c 'hyprctl keyword monitor HEADLESS-2,$${SUNSHINE_CLIENT_WIDTH}x$${SUNSHINE_CLIENT_HEIGHT}@$${SUNSHINE_CLIENT_FPS},auto,1;hyprctl keyword monitor DP-3,disable'";
              undo = "sudo -E -u rhg sh -c 'hyprctl keyword monitor HEADLESS-2,disable;hyprctl reload'";
            }
          ];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
      ];
    };
  };
  services.getty.autologinUser = "rhg";

  programs.droidcam.enable = true;

  programs.nix-ld.enable = true;

  programs.xwayland.enable = true;

  programs.gamemode.enable = true;
  programs.gamemode.settings.general.inhibit_screensaver = 0;
}
