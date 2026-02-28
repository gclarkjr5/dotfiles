{ pkgs, ... }:

let
  repo = pkgs.rustPlatform.buildRustPackage rec {
    pname = "turbocommit";
    version = "v3.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "dikkadev";
      repo = "turboCommit";
      rev = "v3.0.0";
      sha256 = "EFRUCXZCvZWMVQRCes+f06Cl3cEgrwRY8bjS9u/Mtqw=";
    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    cargoSha256 = "EFRUCXZCvZWMVQRCes+f06Cl3cEgrwRY8bjS9u/Mtqw=";

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.zlib pkgs.openssl ];

    doCheck = false;
  };
in
{
  home.packages = [ repo ];
}
