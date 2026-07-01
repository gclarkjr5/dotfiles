{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/kdash-rs/kdash/releases/download/v2.0.2/kdash-macos-arm64.tar.gz";
    sha256 = "a37d700ab1d3680c60e6690d84143e70e08ec4e7ea8edff000e991f3b99a708c";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "kdash";
    version = "v2.0.2";

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
