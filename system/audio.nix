{pkgs, ...}: {
  services.pipewire = pkgs.lib.mkDefault {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    extraConfig.pipewire-pulse = {
      "01-fix-crackling" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "1024/48000";
              pulse.default.req = "1024/48000";
              pulse.max.req = "1024/48000";
              pulse.min.quantum = "1024/48000";
              pulse.max.quantum = "1024/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "1024/48000";
          resample.quality = 1;
        };
      };
    };
    extraConfig.pipewire = {
      "01-fix-crackling" = {
        "context.properties" = {
          "default.clock.force-rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };
}
