{ config, pkgs, ... }:

let
  pkg = pkgs.fetchurl {
    url = "https://downloads.npass.app/mac/NordPass.dmg";
    sha256 = "jKjB2RSAYkohN2mG7yRaJPdDa25YlLneYtkz+UF4ZF0=";
  };
in
{
  home.file."Downloads/NordPass.dmg".source = pkg;
}
