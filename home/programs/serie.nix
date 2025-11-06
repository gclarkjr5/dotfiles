{ config, pkgs, ... }:

let
  system = "aarch64-darwin";

  rust = (pkgs.rust-bin.stable."1.91.0".default).overrideAttrs (old: {
    meta = old.meta or { } // {
      platforms = [ system ];
    };

    # ✅ This is the key fix
    targetPlatforms = [ system ];
  });

  rustPlatform = pkgs.makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };

  serie-from-git = rustPlatform.buildRustPackage rec {
    pname = "serie";
    version = "v0.5.3";

    src = pkgs.fetchFromGitHub {
      owner = "lusingander";
      repo = "serie";
      rev = "v0.5.3"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "HzAgPCAHOdxXPwPWPPU9VaNrVJL42TlbYMD/n7AeOH8=";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    # nativeBuildInputs = with pkgs; [
    #   git
    #   cmake
    #   perl
    #   pkg-config
    # ];
    # buildInputs = [ pkgs.openssl ];
    doCheck = false;
  };
in
{
  home.packages = [ serie-from-git ];
  # home.packages = [ pkgs.gitui ];

  # home.file.".config/gitui/key_bindings.ron".source = ../config/gitui/key_bindings.ron;
}
