{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=14";
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
