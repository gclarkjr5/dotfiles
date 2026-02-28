{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.nushellProfile;
in
{
  options.programs.nushellProfile = {
    configDir = lib.mkOption {
      type = lib.types.path;
      description = "Path to the Nu config directory.";
    };
  };

  config = {
    home.packages = [ pkgs.nushell ];

    home.file."Library/Application Support/nushell/config.nu".source = "${cfg.configDir}/config.nu";
    home.file."Library/Application Support/nushell/env.nu".source = "${cfg.configDir}/env.nu";
    home.file.".config/nushell/config.nu".source = "${cfg.configDir}/config.nu";
    home.file.".config/nushell/env.nu".source = "${cfg.configDir}/env.nu";

    home.file.".custom_nu/nix-switch.nu".source = "${cfg.configDir}/.nix-switch.nu";
  };
}
