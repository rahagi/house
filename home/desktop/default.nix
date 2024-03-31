{pkgs, ...}: {
  imports = [
    ./environment/dwl.nix
    ./programs
    ./terminal
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS-BigSur";
    size = 16;
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
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
  };

  home.file = {
    "./config/user-dirs.dirs" = {
      source = ../../config/user-dirs.dirs;
      target = ".config/user-dirs.dirs";
    };
  };

  home.file = {
    "scripts" = {
      source = ../../tools/scripts;
      target = "scripts";
      recursive = true;
    };
  };
}
