{ pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
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
      mimeType = [ "text/plain" ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
  };

  home.username = "rhg";
  home.homeDirectory = "/home/rhg";

  home.packages = with pkgs; [
    ((dwl.overrideAttrs (prev: {
      patches = [
        ./patches/dwl/ipc.patch
        ./patches/dwl/vanitygaps.patch
        ./patches/dwl/smartborders.patch
        ./patches/dwl/zoomswap.patch
        ./patches/dwl/autostart.patch
        ./patches/dwl/opacity.patch
      ];
      src = fetchgit {
        url = "https://codeberg.org/dwl/dwl";
        rev = "v0.5";
        hash = "sha256-U/vqGE1dJKgEGTfPMw02z5KJbZLWY1vwDJWnJxT8urM=";
      };
      postPatch = ''
      ${prev.postPatch}
      cp "${inputs.colors}/dwl-color.h" color.h
      '';
    })).override { conf = ./config/dwl/config.h; })
    ((somebar.overrideAttrs (prev: {
      version = "master";
      patches = [
        ./patches/somebar/ipc.patch
        ./patches/somebar/dwm-like-tag-indicator.patch
      ];
      src = fetchFromSourcehut {
        owner = "~raphi";
        repo = "somebar";
        rev = "6572b98d697fef50473366bf4b598e66c0be3e54";
        sha256 = "sha256-4s9tj5+lOkYjF5cuFRrR1R1S5nzqvZFq9SUAFuA8QXc=";
      };
      postPatch = ''
      cp "${inputs.colors}/somebar-color.hpp" color.hpp
      '';
    })).override { conf = ./config/somebar/config.hpp; })
    (pkgs.callPackage ./packages/someblocks.nix { conf = ./config/someblocks/blocks.h; })
    pywal
    tofi
    dunst
    swaybg

    firefox

    sxiv

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    fzf

    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    envsubst

    nix-output-monitor

    btop  
    iotop
    iftop
    
    strace
    ltrace
    lsof
    
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    bun
    gcc
    python3

    sops
    gitleaks

    # nvim lsp
    lua-language-server
    nil

    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    dbus
    dconf

    discord
    chatterino2
    mpv

    pamixer
    wlr-randr

    slurp
    grim
    wl-clipboard
    libnotify
    ueberzugpp
    ffmpegthumbnailer
    imagemagick
    (ctpv.overrideAttrs(prev: { patches = [ ./patches/ctpv/chafa-polite-flag.patch ]; }))
    chafa
    xdragon
    poppler_utils
    zathura
    pfetch-rs
  ];

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.keyFile = "/home/rhg/.config/sops/age/keys.txt";
  sops.secrets.private-gpg-keys = {};
  sops.secrets.public-gpg-keys = {};
  sops.secrets.ssh-config = {};

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      pull.ff = "on";
      commit.gpgsign = true;
      user = {
        email = "rahagi@protonmail.com";
        name = "Rahagi Ahnaf Saidani";
        signingKey = "BFA9749D82BD73D9";
      };
    };
  };

  programs.ssh = {
    enable = true;
    includes = [ "config.d/servers" ]; # use config from secret
  };

  programs.gpg = {
    enable = true;
    settings = {
      pinentry-mode = "loopback";
    };
  };

  programs.zsh = {
    enable = true;
    history = {
      extended = false;
      path = "$HOME/.zsh_history";
    };
    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "F-Sy-H.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.66";
          sha256 = "0mvc8mjgmp2ssj621qc1mmskrsqy7fw4x1pf3kgnpm5pz9fyp0ms";
        };
      }
    ];
  };

  programs.tmux = {
    package = with pkgs; tmux.overrideAttrs(prev: rec {
      version = "3.4";
      src = fetchFromGitHub {
        owner = "tmux";
        repo = "tmux";
        rev = version;
        sha256 = "sha256-RX3RZ0Mcyda7C7im1r4QgUxTnp95nfpGgQ2HRxr0s64=";
      };
      configureFlags = prev.configureFlags ++ [ "--enable-sixel" ];
    });
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
    plugins = with pkgs; [ tmuxPlugins.resurrect tmuxPlugins.sensible ];
    extraConfig = ''
    set -g status-style 'bg=#333333'
    set -s escape-time 0
    set -g mouse on
    set-window-option -g mode-keys vi
    set -g allow-passthrough on
    set -ga update-environment TERM
    set -ga update-environment TERM_PROGRAM

    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    bind r source-file ~/./config/tmux/tmux.conf \; display "config reloaded"
    bind c new-window -c "#{pane_current_path}"
    bind-key % split-window -h -c "#{pane_current_path}"
    bind-key '"' split-window -v -c "#{pane_current_path}"
    '';
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        enable_tab_bar = false,
        force_reverse_video_cursor = true,
        font = wezterm.font_with_fallback({
          "monospace",
          { family = "Symbols Nerd Font Mono", scale = 0.75 },
        }),
        line_height = 0.975,
        warn_about_missing_glyphs = false,
        window_padding = {
          left = '2cell',
          right = '2cell',
          top = '0.75cell',
          bottom = '0.5cell',
        },
      }
    '';
  };

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

  home.file = {
    ".zshrc" = {
      source = ./config/zsh/.zshrc;
      target = ".zshrc";
    };
    ".zprofile" = {
      source = ./config/zsh/.zprofile;
      target = ".zprofile";
    };
  };

  home.file = {
    "./config/user-dirs.dirs" = {
      source = ./config/user-dirs.dirs;
      target = ".config/user-dirs.dirs";
    };
  };

  home.file = {
    "./config/tofi" = {
      source = ./config/tofi;
      target = ".config/tofi";
      recursive = true;
    };
  };

  home.file = {
    "./config/dunst" = {
      source = ./config/dunst;
      target = ".config/dunst";
      recursive = true;
    };
  };

  home.file = {
    "./config/dwl-mimeapps.list" = {
      source = ./config/dwl-mimeapps.list;
      target = ".config/dwl-mimeapps.list";
    };
  };

  home.file = {
    "scripts" = {
      source = ./tools/scripts;
      target = "scripts";
      recursive = true;
    };
  };

  home.file = {
    "wallpaper.jpg" = {
      source = ./wallpaper.jpg;
      target = ".cache/wallpaper.jpg";
    };
    "wal-config" = {
      source = ./config/wal;
      target = ".config/wal";
      recursive = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
