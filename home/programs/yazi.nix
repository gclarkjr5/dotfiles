{ config, pkgs, ... }:

{
  home.packages = [ pkgs.yazi ];

  home.file.".config/yazi/init.lua".source = ../config/yazi/init.lua;
  home.file.".config/yazi/keymap.toml".source = ../config/yazi/keymap.toml;
  home.file.".config/yazi/theme.toml".source = ../config/yazi/theme.toml;
  home.file.".config/yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  home.file.".config/yazi/package.toml".source = ../config/yazi/package.toml;
}
