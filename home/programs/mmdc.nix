{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mermaid-cli
  ];
}
