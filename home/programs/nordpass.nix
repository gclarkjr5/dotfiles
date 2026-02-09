{ config, pkgs, ... }:

let
  pkg = pkgs.fetchurl {
    url = "https://downloads.npass.app/mac/NordPass.dmg";
    sha256 = "9cc719b0a0a60773b8ff08221b6a757314b19e12624bcf4510e65fc0e2cdb53d";
  };
in
{
  home.file."Downloads/NordPass.dmg".source = pkg;
}
