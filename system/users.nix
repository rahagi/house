{pkgs, ...}: {
  users.users.rhg = {
    linger = true;
    isNormalUser = true;
    description = "rhg";
    extraGroups = ["networkmanager" "wheel"];
  };
  users.defaultUserShell = pkgs.zsh;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCTBQiDhaRA85++u/X9hJFTLYic4f4hFkDNtvk9OoxJ6FIs3qwGm6oQRkgq4+vBd2hmYVSQBt4UJAZIj23t88vicMnp0I652uYgHgVFoiyvl4An/EguHHbaIGd5pWdpsCqH4t7+jh9BdrCtHeaMWVkt1q8k2lSqBZ7Jg+IvkRBTWyai4FKlz93kWRvidnRDwLl3R2MNN/OMz5srLIhG1hgERf3BsSS1b+syfXyMTPDYHUNjHrfsNbYkJ/x/iCXMKEL4wcA/smAgjNU3s9GJ7FJ3Mmxd2FSSWZh4x432Jm6s7CfBtzpTbSuA4lkxJe+6Mg63AqudbpAFFGTx4LzQNWHM38uSxoDFsoBEHxs8xWm3TNqeRgjGRU5byen7C0d44b9rMcxqJOlbaDW0NC02tpY8lc/8RIi64uDS3wEKfnV/MWulr1nbgMcgkaQ4XkX3dNogxttNEDzvipciZ73Xg68EChGDko7ZI1+TKCjmCPSEJjbGXZ0EW+qKZ7UHWsZBMYc= rhg@blackbox"
  ];
}
