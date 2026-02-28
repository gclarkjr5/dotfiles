{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # fedex only modules here
  ];

  programs.nushellProfile.configDir = ../config/fedex/nushell;
  programs.gitProfile.hostname = "MAC-K03793KGLV";

  home.file =
    lib.mkIf (builtins.pathExists "${config.programs.nushellProfile.configDir}/.gcloud_encryption.nu")
      {
        ".custom_nu/.gcloud_encryption.nu".source =
          "${config.programs.nushellProfile.configDir}/.gcloud_encryption.nu";
      };
}
