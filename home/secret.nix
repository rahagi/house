{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/home/rhg/.config/sops/age/keys.txt";

  sops.secrets.private-gpg-keys = {};
  sops.secrets.public-gpg-keys = {};
  sops.secrets.ssh-config = {};
}
