{ config, pkgs, ... }:

let
  pkg = pkgs.fetchurl {
    url = "https://downloads.nordcdn.com/apps/macos/generic/NordVPN-OpenVPN/latest/NordVPN.pkg";
    sha256 = "9cc719b0a0a60773b8ff08221b6a757314b19e12624bcf4510e65fc0e2cdb53d";
  };

  release = pkgs.stdenv.mkDerivation {
    pname = "nordvpn";
    # version = "";

    # Just downloads it. macOS doesn't allow .pkg to be installed by Nix directly.
    # 
    home.file."Downloads/NordVPN.pkg".source = pkg;
  };

in
{
  home.packages = [ release ];
}
