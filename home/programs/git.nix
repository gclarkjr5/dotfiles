{ config, lib, pkgs, ... }:

let
  cfg = config.programs.gitProfile;
  userEmail =
    if cfg.userEmail != null then
      cfg.userEmail
    else if cfg.hostname == "MAC-K03793KGLV" then
      "gary.clark.osv@fedex.com"
    else
      "gclarkjr5@gmail.com";
in
{
  options.programs.gitProfile = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Hostname used to pick the Git user email.";
    };
    userEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Explicit Git user email override for this profile.";
    };
  };

  programs.git = {
    settings.user.name = "Gary Clark";
    settings.user.email = userEmail;
  };

}
