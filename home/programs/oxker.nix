{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/mrjackwills/oxker/releases/download/v0.13.2/oxker_apple_darwin_aarch64.tar.gz";
    sha256 = "9b18a693f42993786e4aad1643f3f97b90871aaea6a914c6f31ddade1e35cc72";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "oxker";
    version = "v0.13.2";

    src = tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp $pname $out/bin/
      chmod +x $out/bin/$pname
    '';
  };

in
{
  home.packages = [ github-release ];
}
