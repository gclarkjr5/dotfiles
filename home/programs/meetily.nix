{ config, pkgs, ... }:

let
  dmg = pkgs.fetchurl {
    url = "https://github.com/Zackriya-Solutions/meetily/releases/download/v0.4.1/meetily_0.4.1_aarch64.dmg";
    sha256 = "16f84b1769619ba3da93bc43e9c1fa3320ce2b00cc9e99225a3d21302770eaf5";
  };
in
{
  home.file."Downloads/meetily_0.4.1_aarch64.dmg".source = dmg;
}
