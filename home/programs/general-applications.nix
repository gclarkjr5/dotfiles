{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dbeaver-bin
    aerospace
  ];

  home.file.".aerospace.toml".source = "${config.my.configRoot}/.aerospace.toml";
}
