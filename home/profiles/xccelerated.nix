{ config, lib, pkgs, ... }:

{
  imports = [
    # xccelerated only modules here
  ];

  programs.nushellProfile.configDir = ../config/xccelerated/nushell;

  home.file = lib.mkIf (builtins.pathExists "${config.programs.nushellProfile.configDir}/.fnm.nu") {
    ".custom_nu/.fnm.nu".source = "${config.programs.nushellProfile.configDir}/.fnm.nu";
  };

}
