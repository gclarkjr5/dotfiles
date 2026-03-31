{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/CleverCloud/mdr/releases/download/v0.2.8/mdr-aarch64-apple-darwin.tar.gz";
    sha256 = "sha256:7e3aa9c286d45fa8f0e8c1f002f10038ac282f62dfc368856ac141c5f39f9132";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "mdr";
    version = "v0.2.8";

    src = tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp mdr $out/bin/
      chmod +x $out/bin/mdr
    '';
  };

in
{
  home.packages = [ github-release ];
}
