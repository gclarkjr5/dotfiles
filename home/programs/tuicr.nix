{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/agavra/tuicr/releases/download/v0.19.1/tuicr-0.19.1-aarch64-apple-darwin.tar.gz";
    sha256 = "f89a6682defb9b81084ee89dde6bde64b7fe6e8b90788a7a3490d2d6cacbf2d4";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "tuicr";
    version = "v0.19.1";

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
