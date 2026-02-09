{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wezterm ];

  home.file.".config/wezterm/wezterm.lua".source = ../config/wezterm.lua;
  home.file.".wezterm.lua".source = ../config/wezterm.lua;
}
