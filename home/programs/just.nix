{
  config,
  pkgs,
  ...
}:

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

  pkg-from-git = rustPlatform.buildRustPackage rec {
    pname = "just";
    version = "1.58.0";

    src = pkgs.fetchFromGitHub {
      owner = "casey";
      repo = "just";
      rev = "1.58.0"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "yAjirHM3/+Pv9AhcaW7Ab992vwQhh20axK42Gl2LNEA=";

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
