{ config, pkgs, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  userEmail = if hostname == "MAC-K03793KGLV" then "gary.clark.osv@fedex.com" else "gclarkjr5@gmail.com";
in {
  programs.git = {
  userName = "Gary Clark";
  inherit userEmail;
  };
 
}
