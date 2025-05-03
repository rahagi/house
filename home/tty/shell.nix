{pkgs, ...}: {
  home.file.".zshrc".source = ../../config/zsh/.zshrc;
  home.file.".zprofile".source = ../../config/zsh/.zprofile;

  programs.zsh = {
    enable = true;
    history = {
      extended = false;
      path = "$HOME/.zsh_history";
    };
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.66";
          sha256 = "0mvc8mjgmp2ssj621qc1mmskrsqy7fw4x1pf3kgnpm5pz9fyp0ms";
        };
      }
      {
        name = "zsh-window-title";
        src = pkgs.fetchFromGitHub {
          owner = "olets";
          repo = "zsh-window-title";
          rev = "v1.2.0";
          sha256 = "sha256-RqJmb+XYK35o+FjUyqGZHD6r1Ku1lmckX41aXtVIUJQ=";
        };
      }
    ];
  };
}
