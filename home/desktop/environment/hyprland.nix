{
  pkgs,
  lib,
  config,
  # hyprland-plugins,
  ...
}: let
  cfg = config.desktopEnvironment.hyprland;
  # hyprPluginPkgs = hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  # hypr-plugin-dir = pkgs.symlinkJoin {
  #   name = "hyrpland-plugins";
  #   paths = with hyprPluginPkgs; [
  #     csgo-vulkan-fix
  #   ];
  # };
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

    # programs.zsh.localVariables = {HYPR_PLUGIN_DIR = hypr-plugin-dir;};

    xdg.configFile."waybar" = {
      source = cfg.waybar.configDir;
      recursive = true;
    };

    xdg.configFile."hypr" = {
      source = cfg.hypr.configDir;
      recursive = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = "*";
        };
      };
    };
  };
}
