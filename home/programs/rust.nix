{ lib, pkgs, ... }:

# Rust is managed by rustup rather than a single pinned toolchain, so each
# project can get the version it needs:
#   - repos with a `rust-toolchain.toml` (or `rustup override set <ver>`) get
#     that toolchain, installed on first use;
#   - repos with a flake dev shell get their own toolchain via direnv
#     (see ./direnv.nix), which takes precedence on PATH;
#   - everything else uses the rustup default (stable).
# Update with `rustup update`.
#
# Note: rustup ships its own rust-analyzer/rustfmt/clippy proxies, so
# `pkgs.rust-analyzer` must not be installed alongside it.

let
  rustTargets = [
    "aarch64-apple-darwin"
    "aarch64-apple-ios"
    "aarch64-apple-ios-sim"
  ];
in
{
  home.packages = with pkgs; [
    rustup
    bacon
  ];

  # First-time setup only: pick a default toolchain and add the usual extras.
  # Non-fatal, so a switch never fails because of the network.
  home.activation.rustupDefault = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! ${pkgs.rustup}/bin/rustup default >/dev/null 2>&1; then
      run ${pkgs.rustup}/bin/rustup default stable || true
      run ${pkgs.rustup}/bin/rustup component add rust-analyzer || true
      run ${pkgs.rustup}/bin/rustup target add ${lib.concatStringsSep " " rustTargets} || true
    fi
  '';
}
