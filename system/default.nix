{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./security.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # chaotic.scx.enable = true;
  # chaotic.scx.scheduler = "scx_rustland";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  i18n.supportedLocales = ["en_US.UTF-8/UTF-8"];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.rhg = {
    isNormalUser = true;
    description = "rhg";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    ripgrep
    zerotierone
    openssl
    bc
    inetutils

    gnumake
    cmake
    pkg-config
    nix-prefetch-scripts

    fuse3
    exfat
    exfatprogs
    ntfs3g
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/home/rhg/.config/sops/age/keys.txt";
  sops.secrets.zerotier-network-id = {};
  services.zerotierone = {
    enable = true;
    localConf = {
      settings = {softwareUpdate = "disable";};
    };
  };
  systemd.services.join-zerotier-network = {
    description = "Join ZeroTier Network";
    script = ''
      ${pkgs.zerotierone}/bin/zerotier-cli join $(cat ${config.sops.secrets.zerotier-network-id.path})
      ${pkgs.zerotierone}/bin/zerotier-cli set $(cat ${config.sops.secrets.zerotier-network-id.path}) allowDNS=1
    '';
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=;"
    ];
  };

  nix.extraOptions = ''
    trusted-users = root rhg
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  services.openssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = "";
    enableGlobalCompInit = false;
    setOptions = [];
  };
  users.defaultUserShell = pkgs.zsh;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  fonts = {
    packages = with pkgs;
      [
        maple-mono.variable
        siji
        twemoji-color-font
        noto-fonts-color-emoji
        noto-fonts
        noto-fonts-cjk-sans
        (pkgs.callPackage ../packages/kairaga.nix {})
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    fontconfig = {
      subpixel.rgba = "rgb";
      subpixel.lcdfilter = "default";
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        monospace = ["MapleMono"];
      };
    };
  };

  services.avahi.nssmdns4 = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      server = ["192.168.2.1" "/u.wu/10.147.17.34"];
      bind-interfaces = true;
    };
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
