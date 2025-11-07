{pkgs,...}: {
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.wayprompt;
    pinentry.program = "pinentry-wayprompt";
  };
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };
}
