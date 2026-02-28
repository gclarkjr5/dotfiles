{ pkgs, ... }:

let
  repo = pkgs.rustPlatform.buildRustPackage rec {
    pname = "turbocommit";
    version = "v3.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "dikkadev";
      repo = "turboCommit";
      rev = "v3.0.0";
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
