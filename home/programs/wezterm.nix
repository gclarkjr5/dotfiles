{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wezterm ];

  home.file.".wezterm.lua".source = "${config.my.configRoot}/wezterm.lua";
}
