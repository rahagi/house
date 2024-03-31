{...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = "sxiv.desktop";
      "image/png" = "sxiv.desktop";
      "image/gif" = "sxiv.desktop";
      "image/svg" = "sxiv.desktop";
      "text/plain" = "nvim.desktop";
      "text/json" = "nvim.desktop";
      "text/html" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/yaml" = "nvim.desktop";
    };
  };
}
