{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nix ];

  home.file.".config/nix/nix.conf".source = "${config.my.configRoot}/nix/nix.conf";
}
