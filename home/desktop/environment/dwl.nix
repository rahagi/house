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
    enable = lib.mkEnableOption "Enable dwl desktop environment";

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

  config = lib.mkIf cfg.enable {
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
            rev = "4cb24afeaf5a83701a43fcb228012a268a9abf7e";
            sha256 = "sha256-AN02Qlh8zXPWGSKPS/7F4k6aL/5I1sr0Tu2aoarZDUM=";
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
