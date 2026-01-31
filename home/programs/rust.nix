{ config, pkgs, ... }:

# {
#   home.packages = with pkgs; [
#     rustc
#     cargo
#     clippy
#     rustfmt
#     rust-analyzer
#   ];
# }

let
  rustTargets = [
    "aarch64-apple-darwin"
    "aarch64-apple-ios-sim"
  ];
in
{
  home.packages = with pkgs; [
    (rust-bin.stable."1.91.0".default.override { targets = rustTargets; })
    (rust-bin.stable.latest.default.override { targets = rustTargets; })
    (rust-bin.nightly.latest.default.override { targets = rustTargets; })
    rust-analyzer
    bacon
  ];
}
