{...}: {
  programs.gpg = {
    enable = true;
    settings = {
      pinentry-mode = "loopback";
    };
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };
}
