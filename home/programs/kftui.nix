{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/hcavarsan/kftray/releases/download/v0.27.30/kftui_macos_universal.tar.gz";
    sha256 = "b3da9eb9afd0d3aa0bdc4f7c00a3c1d2f4a6698c929161e5c7be103a248b0525";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "kftui";
    version = "v0.27.30";

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
