{
  pkgs,
  inputs,
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
      ((dwl.overrideAttrs (prev: {
          patches = [
            ../../../patches/dwl/ipc.patch
            ../../../patches/dwl/vanitygaps.patch
            ../../../patches/dwl/smartborders.patch
            ../../../patches/dwl/zoomswap.patch
            ../../../patches/dwl/autostart.patch
            ../../../patches/dwl/opacity.patch
          ];
          src = fetchgit {
            url = "https://codeberg.org/dwl/dwl";
            rev = "v0.5";
            hash = "sha256-U/vqGE1dJKgEGTfPMw02z5KJbZLWY1vwDJWnJxT8urM=";
          };
          postPatch = ''
            ${prev.postPatch}
            cp "${inputs.colors}/dwl-color.h" color.h
          '';
        }))
        .override {conf = cfg.dwl.configFile;})
    ];
    xdg.configFile."yambar" = {
      source = cfg.yambar.configDir;
      recursive = true;
    };
  };
}
