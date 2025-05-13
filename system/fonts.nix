{pkgs, ...}: {
  fonts = {
    packages = with pkgs;
      [
        maple-mono.variable
        siji
        twemoji-color-font
        noto-fonts-color-emoji
        noto-fonts
        noto-fonts-cjk-sans
        (pkgs.callPackage ../packages/kairaga.nix {})
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    fontconfig = {
      subpixel.rgba = "rgb";
      subpixel.lcdfilter = "default";
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        monospace = ["MapleMono"];
      };
    };
  };
}
