{ config, pkgs, ... }:

let
  system = "aarch64-darwin";

  rust = (pkgs.rust-bin.stable."1.98.0".default).overrideAttrs (old: {
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

  pkg-from-git = rustPlatform.buildRustPackage rec {
    pname = "starship";
    version = "v1.26.0";

    src = pkgs.fetchFromGitHub {
      owner = "starship";
      repo = "starship";
      rev = "v1.26.0"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "pStNE8SMMVavL3ld6RO+5QQRJPXpqlU3asccS2tUoMQ=";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    doCheck = false;
  };
in

{
  home.packages = [ pkg-from-git ];

  home.file.".config/starship.toml".source = "${config.my.configRoot}/starship.toml";
}
