{ config, pkgs, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  userEmail =
    if hostname == "MAC-K03793KGLV" then "gary.clark.osv@fedex.com" else "gclarkjr5@gmail.com";
in
{
  programs.git = {
    settings.user.name = "Gary Clark";
    settings.user.email = {
      inherit userEmail;
    };
  };

}
