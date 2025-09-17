{ config, pkgs, ... }:

let
  gitui-from-master = pkgs.rustPlatform.buildRustPackage rec {
    pname = "gitui";
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "extrawurst";
      repo = "gitui";
      rev = "f5893d991f66530dcefc48c9020ade77e33edfb9"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "xV0x1oJ+PrGqaye9QJ1XJPj5pzzZdgukW+RYhTh2Pt8=";

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
