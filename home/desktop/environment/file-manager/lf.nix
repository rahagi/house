{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    commands = {
      open = ''$$OPENER "$f"'';
    };
    keybindings = {
      D = "delete";
      "<f-7>" = ''push :mkdir<space>""<c-b>'';
      "<c-d>" = "!dragon -a $fx";
    };
    settings = {
      sixel = true;
    };
    extraConfig = ''
    set previewer ctpv
    set cleaner ctpvclear
    &ctpv -s $id
    &ctpvquit $id

    cmd quit-and-cd &{{
      pwd > $LF_CD_FILE
      lf -remote "send $id quit"
    }}
    map q quit-and-cd
    '';
  };

  home.packages = with pkgs; [ 
    (ctpv.overrideAttrs(prev: { patches = [ ../../../../patches/ctpv/chafa-polite-flag.patch ]; }))
  ];
}
