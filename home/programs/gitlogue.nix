{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/unhappychoice/gitlogue/releases/download/v0.9.0/gitlogue-v0.9.0-aarch64-apple-darwin.tar.gz";
    sha256 = "a0a0267b5b121ea3a3026c8bf5334b11de4c13c3cc45c2bb796ab481a59150a2";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "gitlogue";
    version = "v0.9.0";

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
