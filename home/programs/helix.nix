{ config, pkgs, ... }:

{
  home.packages = [ pkgs.helix ];

  home.file.".config/helix/config.toml".source = "${config.my.configRoot}/helix/config.toml";
  home.file.".config/helix/languages.toml".source = "${config.my.configRoot}/helix/languages.toml";
}
