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

  gitui-from-master = rustPlatform.buildRustPackage rec {
    pname = "gitui";
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "extrawurst";
      repo = "gitui";
      rev = "cb17cfe10540c66252e9f06753dbe17031736beb"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "JT5GqxvENSxeteZ6j+DpNP9dgcko1UGNFWdZRu1M5oA=";

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
  home.packages = [ gitui-from-master ];
  # home.packages = [ pkgs.gitui ];

  home.file.".config/gitui/key_bindings.ron".source = ../config/gitui/key_bindings.ron;
}
