{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dbeaver
    duckdb
    signal-desktop-bin
  ];
}
