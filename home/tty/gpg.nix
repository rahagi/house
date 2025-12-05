{pkgs,...}: {
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    pinentry.program = "pinentry-curses";
  };
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };
}
