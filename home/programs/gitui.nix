{ config, pkgs, ... }:

let
  gitui-from-master = pkgs.rustPlatform.buildRustPackage rec {
    pname = "gitui";
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "extrawurst";
      repo = "gitui";
      rev = "master"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };

    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.openssl ];
  };
in
{
  home.packages = [ gitui-from-master ];
  # home.packages = [ pkgs.gitui ];

  home.file.".config/gitui/key_bindings.ron".source = ../config/gitui/key_bindings.ron;
}
