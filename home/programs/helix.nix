{ config, pkgs, ... }:

{
  home.packages = [ pkgs.helix ];

  home.file.".config/helix/config.toml".source = ../config/helix/config.toml;
  home.file.".config/helix/languages.toml".source = ../config/helix/languages.toml;
}
