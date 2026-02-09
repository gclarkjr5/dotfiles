{ config, pkgs, ... }:

let
  exe = pkgs.fetchurl {
    url = "https://github.com/neondatabase/neonctl/releases/download/v2.20.2/neonctl-macos-x64";
    sha256 = "55adffe200d292710f254f1f16fef259d0416db2d922ec1d306db1c2786fd65c";
  };

  github-releases = pkgs.stdenv.mkDerivation {
    pname = "neonctl";
    version = "v2.20.2";

    src = exe;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/neonctl
    '';
  };

in
{
  home.packages = [ github-releases ];
}
