{pkgs, ...}: {
  programs.lf = {
    enable = true;
    commands = {
      open = ''$$OPENER "$f"'';
    };
    keybindings = {
      D = "delete";
      p = "paste; clear";

      r = "";
      i = "rename";
      I = ":rename; cmd-home";
      a = ":rename; cmd-end";
      c = ":rename; cmd-delete-home";
      C = ":rename; cmd-end; cmd-delete-home";

      gh = ''$lf -remote "send $id cd $HOME"'';
      gm = ''$lf -remote "send $id cd /mnt/"'';
      gd = ''$lf -remote "send $id cd $HOME/downloads"'';

      "<f-7>" = ''push %mkdir<space>""<c-b>'';
      "<c-d>" = ''!dragon-drop -a "$fx"'';
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

      cmd extract &{{
        set -f
        atool -x $f
      }}
      map e extract
    '';
  };

  home.packages = with pkgs; [
    (ctpv.overrideAttrs (prev: {patches = [../../../../patches/ctpv/chafa-polite-flag.patch];}))
  ];
  xdg.configFile."ctpv" = {
    source = ../../../../config/ctpv;
    recursive = true;
  };
}
