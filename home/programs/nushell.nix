{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nushell ];

  home.file."Library/Application Support/nushell/config.nu".source = ../config/nushell/config.nu;
  home.file."Library/Application Support/nushell/env.nu".source = ../config/nushell/env.nu;
  home.file.".custom_nu/gcloud_encryption.nu".source = ../config/nushell/gcloud_encryption.nu;
}
