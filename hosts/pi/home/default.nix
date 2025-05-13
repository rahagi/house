{...}: {
  imports = [
    ../home/secret.nix
    ../home/tty
  ];

  home = {
    username = "rhg";
    homeDirectory = "/home/rhg";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

