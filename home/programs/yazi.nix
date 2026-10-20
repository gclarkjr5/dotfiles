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
    pname = "yazi";
    version = "v26.9.1";

    src = pkgs.fetchFromGitHub {
      owner = "sxyazi";
      repo = "yazi";
      # rev = "v0.28.1";

      rev = "v26.9.1"; # You can replace this with a specific commit for stability
      fetchSubmodules = true;
      # ↓ Use `nix build` to get the right sha256 and replace this dummy
      # 0000000000000000000000000000000000000000000000000000
      sha256 = "/8j4bEbT8DR/xlWtt62FXVyeHyWtBlvV8Rq0VbtY6ms=";

    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "ratatui-core-0.1.2" = "sha256-wbbG0PbGolztosfuXzVZ6MvgbDRfp8UqmRjvbCDyZFg=";
      };
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
  home.packages = [
    pkg-from-git
  ];

  home.file.".config/yazi/init.lua".source = "${config.my.configRoot}/yazi/init.lua";
  home.file.".config/yazi/keymap.toml".source = "${config.my.configRoot}/yazi/keymap.toml";
  home.file.".config/yazi/theme.toml".source = "${config.my.configRoot}/yazi/theme.toml";
  home.file.".config/yazi/yazi.toml".source = "${config.my.configRoot}/yazi/yazi.toml";

  # packages
  home.file.".config/yazi/plugins/arrow.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/arrow.yazi/main.lua";
  home.file.".config/yazi/plugins/duckdb.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/duckdb.yazi/main.lua";
  home.file.".config/yazi/plugins/fg.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/fg.yazi/main.lua";
  home.file.".config/yazi/plugins/folder-rules.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/folder-rules.yazi/main.lua";
  home.file.".config/yazi/plugins/full-border.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/full-border.yazi/main.lua";
  home.file.".config/yazi/plugins/git.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/git.yazi/main.lua";
  home.file.".config/yazi/plugins/gitui.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/gitui.yazi/main.lua";
  home.file.".config/yazi/plugins/mdcat.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/mdcat.yazi/main.lua";
  home.file.".config/yazi/plugins/mime-ext.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/mime-ext.yazi/main.lua";
  home.file.".config/yazi/plugins/parent-arrow.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/parent-arrow.yazi/main.lua";
  home.file.".config/yazi/plugins/smart-enter.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/smart-enter.yazi/main.lua";
  home.file.".config/yazi/plugins/smart-filter.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/smart-filter.yazi/main.lua";
  home.file.".config/yazi/plugins/starship.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/starship.yazi/main.lua";
  home.file.".config/yazi/plugins/toggle-pane.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/toggle-pane.yazi/main.lua";
  home.file.".config/yazi/plugins/vcs-files.yazi/main.lua".source =
    "${config.my.configRoot}/yazi/plugins/vcs-files.yazi/main.lua";
}
