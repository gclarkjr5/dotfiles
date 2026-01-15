{ config, pkgs, ... }:

let
  gurk-tarball = pkgs.fetchurl {
    url = "https://github.com/boxdot/gurk-rs/releases/download/v0.8.1/gurk-aarch64-apple-darwin.tar.gz";
    sha256 = "8c7a454536bcc950248fb084225721de1b1ace076ed92d82743e57231544b386";
  };

  gurk-from-github-releases = pkgs.stdenv.mkDerivation {
    pname = "gurk";
    version = "v0.8.1";

    src = gurk-tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp gurk $out/bin/
      chmod +x $out/bin/gurk
    '';
  };

in
{
  home.packages = [ gurk-from-github-releases ];
  home.file."Library/Application Support/gurk/gurk.toml".source = ../config/gurk/gurk.toml;
}
