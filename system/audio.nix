{pkgs, ...}: {
  services.pipewire = pkgs.lib.mkDefault {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
