{ config, pkgs, ... }:

let
  # system = "aarch64-darwin";

  # rust = (pkgs.rust-bin.stable."1.91.0".default).overrideAttrs (old: {
  #   meta = old.meta or { } // {
  #     platforms = [ system ];
  #   };

  #   # ✅ This is the key fix
  #   targetPlatforms = [ system ];
  # });

  # rustPlatform = pkgs.makeRustPlatform {
  #   cargo = rust;
  #   rustc = rust;
  # };

  gurk-tarball = pkgs.fetchurl {
    url = "https://github.com/boxdot/gurk-rs/releases/download/v0.8.1/gurk-aarch64-apple-darwin.tar.gz";
    sha256 = "8c7a454536bcc950248fb084225721de1b1ace076ed92d82743e57231544b386";
  };

  gurk-from-github-releases = pkgs.stdenv.mkDerivation {
    pname = "gurk";
    version = "v0.8.1";

    src = gurk-tarball;

    installPhase = ''
      # mkdir -p $out/bin
      tar -xzf $src
      cp gurk $out/bin/
    '';
  };

  # gurk-from-git = rustPlatform.buildRustPackage rec {
  #   pname = "gurk-rs";
  #   version = "v0.8.1";

  #   src = pkgs.fetchFromGitHub {
  #     owner = "boxdot";
  #     repo = "gurk-rs";
  #     rev = "v0.8.1"; # You can replace this with a specific commit for stability
  #     fetchSubmodules = true;
  #     # ↓ Use `nix build` to get the right sha256 and replace this dummy
  #     sha256 = "HBqKcKPsNJQhLGGQ4X+xGPWwSABiaqubn11yyqiL0xU="; # 0000000000000000000000000000000000000000000000000000

  #   };

  #   cargoLock = {
  #     lockFile = "${src}/Cargo.lock";
  #   };
  #   # ↓ You'll need to fill this in with the correct hash too
  #   cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  #   # nativeBuildInputs = with pkgs; [
  #   #   git
  #   #   cmake
  #   #   perl
  #   #   pkg-config
  #   # ];
  #   # buildInputs = [ pkgs.openssl ];
  #   # doCheck = false;
  # };
in
{
  home.packages = [ gurk-from-github-releases ];
  # home.packages = [ pkgs.gitui ];

  # home.file.".config/gitui/key_bindings.ron".source = ../config/gitui/key_bindings.ron;
}
