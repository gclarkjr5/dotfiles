{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/bahdotsh/wrkflw/releases/download/v0.8.0/wrkflw-aarch64-apple-darwin.tar.gz";
    sha256 = "119932dc5c27e146a9ca88247a600a20054b7a243f790615057c81b5aca2bc78";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "wrkflw";
    version = "v0.8.0";

    src = tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp $pname $out/bin/
      chmod +x $out/bin/blippy
    '';
  };

in
{
  home.packages = [ github-release ];
  # home.file."Library/Application Support/gurk/gurk.toml".source =
  # "${config.my.configRoot}/gurk/gurk.toml";
}
