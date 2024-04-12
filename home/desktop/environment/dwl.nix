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

    somebar.configFile = lib.mkOption {
      description = ''
        Path to somebar's `config.hpp` file
      '';
      default = ../../../config/somebar/config.hpp;
    };

    someblocks.configFile = lib.mkOption {
      description = ''
        Path to someblock's `blocks.h` file
      '';
      default = ../../../config/someblocks/blocks.h;
    };
  };

  config = {
    home.packages = with pkgs; [
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
      ((somebar.overrideAttrs (prev: {
          version = "master";
          patches = [
            ../../../patches/somebar/ipc.patch
            ../../../patches/somebar/dwm-like-tag-indicator.patch
          ];
          src = fetchFromSourcehut {
            owner = "~raphi";
            repo = "somebar";
            rev = "6572b98d697fef50473366bf4b598e66c0be3e54";
            sha256 = "sha256-4s9tj5+lOkYjF5cuFRrR1R1S5nzqvZFq9SUAFuA8QXc=";
          };
          postPatch = ''
            cp "${inputs.colors}/somebar-color.hpp" color.hpp
          '';
        }))
        .override {conf = cfg.somebar.configFile;})
      (pkgs.callPackage ../../../packages/someblocks.nix {conf = cfg.someblocks.configFile;})
    ];
  };
}
