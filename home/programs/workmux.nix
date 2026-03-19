{ config, pkgs, workmux, ... }:

{
  home.packages = [
    workmux.packages.${pkgs.system}.default
  ];
}
