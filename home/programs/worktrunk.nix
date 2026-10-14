{
  config,
  pkgs,
  ...
}:

let
  system = "aarch64-darwin";

  # atuin v18.23.0 pins rust-toolchain channel 1.98.0 (rust-version = 1.95.0)
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
    pname = "worktrunk";
    version = "v0.80.0";

    src = pkgs.fetchFromGitHub {
      owner = "max-sixty";
      repo = "worktrunk";
      rev = "v0.80.0"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "wT9V9A6ty4yCp/wJ9F92AC5SrsQzemEb8/d2NSjH/SY=";

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
}
