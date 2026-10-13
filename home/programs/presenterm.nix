{ config, pkgs, ... }:

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
    pname = "presenterm";
    version = "v0.16.1";

    src = pkgs.fetchFromGitHub {
      owner = "mfontanini";
      repo = "presenterm";
      rev = "v0.16.1"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "mIJktrgBweaaLD2YaRcs0vP5hKRy/kMN/HEnwO323DA=";

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
