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
    pname = "gitui";
    version = "fcd19704aead8296630dcb83370c6ce050aaecf2";

    src = pkgs.fetchFromGitHub {
      owner = "gclarkjr5";
      repo = "gitui";
      # rev = "v0.28.1";

      rev = "fcd19704aead8296630dcb83370c6ce050aaecf2"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      # 0000000000000000000000000000000000000000000000000000
      sha256 = "fNTeaxHWHc3HFTfXqDBHOaNBsWw+xaThBsJIuEGu6I0=";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    nativeBuildInputs = with pkgs; [
      git
      cmake
      perl
      pkg-config
    ];
    buildInputs = [ pkgs.openssl ];
    doCheck = false;
  };
in
{
  home.packages = [ pkg-from-git ];

  home.file.".config/gitui/key_bindings.ron".source =
    "${config.my.configRoot}/gitui/key_bindings.ron";
}
