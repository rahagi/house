{pkgs, ...}: {
  home.packages = with pkgs; [
    lua-language-server
    nil
    alejandra
    vscode-json-languageserver
    stylua
    marksman
  ];
}
