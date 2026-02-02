{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cocoapods
    xcodegen
  ];
}
