{ config, pkgs, ... }:

{
  home.packages = [ pkgs.atuin ];

  home.file.".config/atuin/config.toml".source = ../config/atuin/config.toml;
}
