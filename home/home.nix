{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER";
  homedir = "/Users/${username}";
in
{
  home.username = username;
  home.homeDirectory = homedir;
  # This is required and should not be changed once set
  home.stateVersion = "23.11";

  imports = [
    ./programs/wezterm.nix
    ./programs/starship.nix
    ./programs/nushell.nix
    ./programs/atuin.nix
    ./programs/shell-tools.nix
    ./programs/gitui.nix
    ./programs/helix.nix
    ./programs/yazi.nix
    ./programs/git.nix
    ./programs/rust.nix
    ./programs/nix.nix
    ./programs/lsps.nix
    ./programs/serie.nix
    ./programs/general-applications.nix
  ];

}
