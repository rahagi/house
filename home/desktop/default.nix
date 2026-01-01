{
  pkgs,
  pkgs-stable,
  ...
}: let
  gtkTheme = pkgs.nightfox-gtk-theme.override {
    tweakVariants = ["carbonfox" "macos"];
  };
  gtkIcon = pkgs.adwaita-icon-theme;
in {
  imports = [
    ./mimeapps.nix
    ./environment/dwl.nix
    ./environment/hyprland.nix
    ./packages
    ./terminal
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.whitesur-cursors;
    name = "WhiteSur-cursors";
    size = 28;
  };

  xdg.desktopEntries = {
    nvim = {
      type = "Application";
      name = "NeoVim";
      comment = "NeoVim text editor";
      icon = "utilities-terminal";
      terminal = true;
      exec = "nvim";
      mimeType = ["text/plain"];
    };
    sxiv = {
      type = "Application";
      name = "sxiv";
      comment = "Simple X Image Viewer";
      exec = "sxiv -a %F";
      terminal = false;
      mimeType = ["image/jpeg" "image/png" "image/gif" "image/webp" "image/svg"];
    };
    lf = {
      type = "Application";
      name = "lf";
      comment = "Terminal file manager";
      terminal = true;
      exec = "lf";
      mimeType = ["inode/directory"];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nightfox-Dark-Carbonfox";
      package = gtkTheme;
    };
    iconTheme = {
      name = "Adwaita";
      package = gtkIcon;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile."user-dirs.dirs".source = ../../config/user-dirs.dirs;
  home.file."scripts" = {
    source = ../../tools/scripts;
    recursive = true;
  };
}
