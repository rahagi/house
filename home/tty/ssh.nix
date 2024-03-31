{...}: {
  programs.ssh = {
    enable = true;
    includes = ["config.d/servers"]; # use config from secret
  };
}
