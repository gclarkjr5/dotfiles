{ config, pkgs, ... }:

let
  rustTargets = [
    "aarch64-apple-darwin"
    "aarch64-apple-ios"
    "aarch64-apple-ios-sim"
  ];

  # Switch this to the toolchain you want on PATH.
  rustToolchain = pkgs.rust-bin.stable."1.91.0".default.override { targets = rustTargets; };
in
{
  home.packages = with pkgs; [
    rustToolchain
    rust-analyzer
    bacon
  ];
}
