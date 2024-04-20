{pkgs, ...}: {
  home.packages = with pkgs; [
    lua-language-server
    nil
    alejandra
    nodePackages_latest.vscode-json-languageserver
    stylua
    marksman
  ];
}
