{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  networking.networkmanager.enable = pkgs.lib.mkDefault true;

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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    ripgrep
    zerotierone
    openssl
    bc
    inetutils

    fuse3
    exfat
    exfatprogs
    ntfs3g
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/home/rhg/.config/sops/age/keys.txt";
  sops.secrets.zerotier-network-id = {};
  # services.zerotierone = {
  #   enable = true;
  #   localConf = {
  #     settings = {softwareUpdate = "disable";};
  #   };
  # };
  # systemd.services.join-zerotier-network = {
  #   description = "Join ZeroTier Network";
  #   script = ''
  #     ${pkgs.zerotierone}/bin/zerotier-cli join $(cat ${config.sops.secrets.zerotier-network-id.path})
  #     ${pkgs.zerotierone}/bin/zerotier-cli set $(cat ${config.sops.secrets.zerotier-network-id.path}) allowDNS=1
  #   '';
  # };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
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
  services.openssh.settings.PermitRootLogin = "without-password";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = "";
    enableGlobalCompInit = false;
    setOptions = [];
  };

  hardware.graphics = pkgs.lib.mkDefault {
    enable = true;
    enable32Bit = true;
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

  services.tailscale.enable = true;
  services.resolved.enable = true;
  networking.useNetworkd = true;
  networking.nftables.enable = true;
  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     server = ["192.168.1.1" "/u.wu/10.147.17.34"];
  #     bind-interfaces = true;
  #   };
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = pkgs.lib.mkDefault "23.11"; # Did you read the comment?
}
