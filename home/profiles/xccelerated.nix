{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # xccelerated only modules here
    ../programs/ios.nix
    ../programs/nordvpn.nix
    ../programs/ralph.nix
    ../programs/turbocommit.nix
  ];

  programs.nushellProfile.configDir = ../config/xccelerated/nushell;
  programs.gitProfile.hostname = "XCCELERATED_HOSTNAME";

  # home.activation.xcceleratedPostSwitch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   if command -v kubectl >/dev/null 2>&1; then
  #     kubectl config unset current-context >/dev/null 2>&1 || true
  #   fi

  #   if command -v gcloud >/dev/null 2>&1; then
  #     gcloud auth login
  #   fi

  #   if command -v az >/dev/null 2>&1; then
  #     az logout
  #   fi
  # '';

  home.activation.xcceleratedProfileName = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/hm-profile"
    printf '%s\n' 'xccelerated' > "$HOME/.config/hm-profile/name"
  '';

  home.file = lib.mkIf (builtins.pathExists "${config.programs.nushellProfile.configDir}/.fnm.nu") {
    ".custom_nu/.fnm.nu".source = "${config.programs.nushellProfile.configDir}/.fnm.nu";
  };

}
