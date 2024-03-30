{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
    ripgrep
    zerotierone
    openssl
    bc

    gnumake
    cmake
    pkg-config
    nix-prefetch-scripts
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
  };
  systemd.services.join-zerotier-network = {
    description = "Join ZeroTier Network";
    script = ''
    ${pkgs.zerotierone}/bin/zerotier-cli join $(cat ${config.sops.secrets.zerotier-network-id.path})
    ${pkgs.zerotierone}/bin/zerotier-cli set $(cat ${config.sops.secrets.zerotier-network-id.path}) allowDNS=1
    '';
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  services.openssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    promptInit = "";
    enableGlobalCompInit = false;
    setOptions = [];
  };
  users.defaultUserShell = pkgs.zsh;

  hardware.opengl.enable = true;

  fonts = {
    packages = with pkgs; [
      maple-mono
      siji
      twemoji-color-font
      noto-fonts
      noto-fonts-cjk
      nerdfonts
      (pkgs.callPackage ../packages/kairaga.nix {})
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "MapleMono" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
