{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nushell ];

  # home.sessionVariables = {
  #   XDG_CONFIG_HOME = "${homedir}/.config";
  #   XDG_DATA_HOME = "${homedir}/.config";
  # };

  home.file."Library/Application Support/nushell/config.nu".source = ../config/nushell/config.nu;
  home.file."Library/Application Support/nushell/env.nu".source = ../config/nushell/env.nu;
  home.file.".config/nushell/config.nu".source = ../config/nushell/config.nu;
  home.file.".config/nushell/env.nu".source = ../config/nushell/env.nu;
  home.file.".custom_nu/.gcloud_encryption.nu".source = ../config/nushell/.gcloud_encryption.nu;
  home.file.".custom_nu/.fnm.nu".source = ../config/nushell/.fnm.nu;
}
