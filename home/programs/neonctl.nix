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

  neonctl-from-tag = rustPlatform.buildRustPackage rec {
    pname = "neonctl";
    version = "v2.20.2";

    src = pkgs.fetchFromGitHub {
      owner = "neondatabase";
      repo = "neonctl";
      rev = "v2.20.2"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      # 0000000000000000000000000000000000000000000000000000
      sha256 = "0000000000000000000000000000000000000000000000000000";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  };
in
{
  home.packages = [ neonctl-from-tag ];
}
