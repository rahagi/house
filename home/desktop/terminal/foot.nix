{...}: {
  programs.foot = {
    enable = true;
    settings = {
      colors = {
        alpha = 0.7;
      };
      main = {
        font = "monospace:size=13";
        dpi-aware = "yes";
        pad = "16x16";
      };
      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "none";
      };
    };
  };
}
