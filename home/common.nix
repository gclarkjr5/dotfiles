{
  config,
  lib,
  pkgs,
  ...
}:

let
  username = builtins.getEnv "USER";
  homedir = "/Users/${username}";
in
{
  options.my.configRoot = lib.mkOption {
    type = lib.types.path;
    default = ./config/common;
    description = "Root path for shared config files.";
  };

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
    ./programs/general-applications.nix
    ./programs/underlying-libs.nix
    ./programs/gurk.nix
    ./programs/nordvpn.nix
    ./programs/nordpass.nix
    ./programs/ralph.nix
    ./programs/mdr.nix
  ];

  config = {
    home.username = username;
    home.homeDirectory = homedir;
    # This is required and should not be changed once set
    home.stateVersion = "23.11";
  };
}
