{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.desktopEnvironment.dwl;
in {
  imports = [
    ../programs/file-manager/lf.nix
    ../programs/launcher/tofi.nix
    ../programs/notification/dunst.nix
    ../programs/utils
  ];

  options.desktopEnvironment.dwl = {
    dwl.configFile = lib.mkOption {
      description = ''
        Path to dwl's `config.h` file
      '';
      default = ../../../config/dwl/config.h;
    };

    yambar.configDir = lib.mkOption {
      description = ''
        Path to yambar's config directory
      '';
      default = ../../../config/yambar;
    };
  };

  config = {
    home.packages = with pkgs; [
      yambar
      (pkgs.callPackage ../../../packages/dwlmsg.nix {})
      ((dwl.overrideAttrs (prev: {
          src = fetchFromGitHub {
            owner = "rahagi";
            repo = "dwl";
            rev = "v0.5.2";
            sha256 = "sha256-NJ6IGyjVNLY0ph8jzSUUw5b3Y1jm7AyUfK85V7v5cYc=";
          };
        }))
        .override {conf = cfg.dwl.configFile;})
    ];
    xdg.configFile."yambar" = {
      source = cfg.yambar.configDir;
      recursive = true;
    };
  };
}
