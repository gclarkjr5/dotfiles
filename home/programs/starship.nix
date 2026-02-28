{ config, pkgs, ... }:

{
  home.packages = [ pkgs.starship ];

  home.file.".config/starship.toml".source = "${config.my.configRoot}/starship.toml";
}
