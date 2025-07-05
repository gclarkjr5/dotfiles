{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    ripgrep
    zoxide
    fzf
    bat
    jless
    inlyne
    file
    poppler
    jq
    zip
  ];

}
