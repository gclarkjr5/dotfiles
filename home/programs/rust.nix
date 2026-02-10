{ config, pkgs, ... }:

let
  rustTargets = [
    "aarch64-apple-darwin"
    "aarch64-apple-ios"
    "aarch64-apple-ios-sim"
  ];

  # Switch this to the toolchain you want on PATH.
  rustToolchain = pkgs.rust-bin.stable."1.91.0".default.override { targets = rustTargets; };
  # rustToolchain =
  #   pkgs.rust-bin.stable.latest.default.override { targets = rustTargets; };
  # rustToolchain =
  #   pkgs.rust-bin.nightly.latest.default.override { targets = rustTargets; };
in
{
  home.packages = with pkgs; [
    rustToolchain
    rust-analyzer
    bacon
  ];

  # 🔧 Add a hook to install rustup
  home.activation.installRustUp = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
      ${pkgs.curl}/bin/curl https://sh.rustup.rs -sSf | sh -s -- -y
    fi
  '';

}
