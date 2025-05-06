{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.desktopEnvironment.hyprland;
in {
  imports = [
    ../programs/file-manager/lf.nix
    ../programs/launcher/tofi.nix
    ../programs/notification/dunst.nix
    ../programs/utils
  ];

  options.desktopEnvironment.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland desktop environment";

    hypr.configDir = lib.mkOption {
      description = ''
        Path to hyprland config directory
      '';
      default = ../../../config/hypr;
    };

    waybar.configDir = lib.mkOption {
      description = ''
        Path to waybar's config directory
      '';
      default = ../../../config/waybar;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprlock
      hyprpolkitagent
      waybar
    ];

    xdg.configFile."waybar" = {
      source = cfg.waybar.configDir;
      recursive = true;
    };

    xdg.configFile."hypr" = {
      source = cfg.hypr.configDir;
      recursive = true;
    };
  };
}
