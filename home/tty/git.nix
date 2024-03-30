{ ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      pull.ff = "on";
      commit.gpgsign = true;
      user = {
        email = "rahagi@protonmail.com";
        name = "Rahagi Ahnaf Saidani";
        signingKey = "BFA9749D82BD73D9";
      };
    };
  };
}
