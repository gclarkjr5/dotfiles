{ pkgs, ... }:

let
  repo = pkgs.rustPlatform.buildRustPackage rec {
    pname = "ralph";
    version = "v2.6.0";

    src = pkgs.fetchFromGitHub {
      owner = "mikeyobrien";
      repo = "ralph-orchestrator";
      rev = "v2.6.0";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    doCheck = false;
  };
in
{
  home.packages = [ repo ];
}
