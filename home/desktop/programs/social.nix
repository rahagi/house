{ pkgs, ... }:

{
  home.packages = with pkgs; [ chatterino2 discord ];
}
