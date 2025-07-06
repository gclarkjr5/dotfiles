{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nix ];

  home.file.".config/nix/nix.conf".source = ../config/nix/nix.conf;
}
