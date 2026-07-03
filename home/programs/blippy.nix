{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/AksharP5/blippy/releases/download/v0.1.6/blippy-aarch64-apple-darwin.tar.gz";
    sha256 = "8e21043437f075b85660e9fe54f033fa5abb4c9c82058ff0e93b09120759e66a";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "blippy";
    version = "v0.1.6";

    src = tarball;
    # dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp blippy $out/bin/
      chmod +x $out/bin/blippy
    '';
  };

in
{
  home.packages = [ github-release ];
  # home.file."Library/Application Support/gurk/gurk.toml".source =
  # "${config.my.configRoot}/gurk/gurk.toml";
}
