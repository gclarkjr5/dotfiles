{
  config,
  pkgs,
  ...
}:

# {
#   home.packages = [ pkgs.atuin ];

#   home.file.".config/atuin/config.toml".source = ../config/atuin/config.toml;
# }

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

  atuin-from-git = rustPlatform.buildRustPackage rec {
    pname = "atuin";
    version = "v18.10.0";

    src = pkgs.fetchFromGitHub {
      owner = "atuinsh";
      repo = "atuin";
      rev = "v18.10.0"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      sha256 = "bfSa3RtVXxHt3usDqqpE/oXKKDUZOrf+tD9uL59fr6M=";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
    # ↓ You'll need to fill this in with the correct hash too
    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    # nativeBuildInputs = with pkgs; [
    #   git
    #   cmake
    #   perl
    #   pkg-config
    # ];
    # buildInputs = [ pkgs.openssl ];
    doCheck = false;
  };
in
{
  home.packages = [ atuin-from-git ];

  home.file.".config/atuin/config.toml".source = ../config/atuin/config.toml;
}
