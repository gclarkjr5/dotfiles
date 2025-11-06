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

{
  home.packages = with pkgs; [
    rust-bin.stable."1.91.0".default
    rust-analyzer
  ];
}
