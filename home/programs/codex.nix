{ config, pkgs, ... }:

let
  codex-tarball = pkgs.fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v0.86.0/codex-aarch64-apple-darwin.tar.gz";
    sha256 = "34d3ccf4b2659644a17c8984413a08ed1594e54f1e46e60bf4d1b90a4b4d083d";
  };

  codex-from-github-releases = pkgs.stdenv.mkDerivation {
    pname = "codex";
    version = "rust-v0.86.0";

    src = codex-tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp codex-aarch64-apple-darwin $out/bin/
      chmod +x $out/bin/codex
    '';
  };

in
{
  home.packages = [ codex-from-github-releases ];
  # home.file."Library/Application Support/gurk/gurk.toml".source = ../config/gurk/gurk.toml;
}
