{pkgs, ...}: {
  programs.tmux = {
    package = with pkgs;
      tmux.overrideAttrs (prev: rec {
        version = "3.4";
        src = fetchFromGitHub {
          owner = "tmux";
          repo = "tmux";
          rev = version;
          sha256 = "sha256-RX3RZ0Mcyda7C7im1r4QgUxTnp95nfpGgQ2HRxr0s64=";
        };
        configureFlags = prev.configureFlags ++ ["--enable-sixel"];
      });
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    # terminal = "screen-256color";
    terminal = "tmux-256color";
    plugins = with pkgs; [tmuxPlugins.resurrect tmuxPlugins.sensible];
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
}
