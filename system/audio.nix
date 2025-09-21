{pkgs, ...}: {
  services.pipewire = pkgs.lib.mkDefault {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    extraConfig.pipewire = {
      "01-fix-cracklng" = {
        "clock.force-rate" = 48000;
        "clock.force-quantum" = 1024;
      };
    };
  };
}
