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
          buildInputs = [
            libinput
            libxkbcommon
            pixman
            wayland
            wayland-protocols
            wlroots_0_18

            xwayland
            xorg.libxcb
            xorg.libX11
            xorg.xcbutilwm
          ];
          src = fetchFromGitHub {
            owner = "rahagi";
            repo = "dwl";
            rev = "v0.7.1-tearing";
            sha256 = "sha256-sp88hlnnmnp2Ibrb8OlH8a54TDKWe4pgZ84lnKE4nD8=";
          };
        }))
        .override {configH = cfg.dwl.configFile;})
    ];
    xdg.configFile."yambar" = {
      source = cfg.yambar.configDir;
      recursive = true;
    };
  };
}
