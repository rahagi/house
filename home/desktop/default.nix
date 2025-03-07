{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./mimeapps.nix
    ./environment/dwl.nix
    ./packages
    ./terminal
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
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
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      package = pkgs-stable.colloid-icon-theme;
      name = "Colloid-Dark";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "kde";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      };
    };
  };

  xdg.configFile."user-dirs.dirs".source = ../../config/user-dirs.dirs;
  home.file."scripts" = {
    source = ../../tools/scripts;
    recursive = true;
  };
}
