{pkgs, ...}: {
  languages.nix.enable = true;

  packages = with pkgs; [
    vscode-langservers-extracted
  ];
}
