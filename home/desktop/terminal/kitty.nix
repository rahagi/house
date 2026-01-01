{...}: {
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+u" = "open_url_with_hints";
    };
    settings = {
      "font_size" = 14.0;
      "window_padding_width" = 11;
      "cursor_trail" = 3;
      "confirm_os_window_close" = 0;
    };
  };
}
