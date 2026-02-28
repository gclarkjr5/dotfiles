{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # fedex only modules here
  ];

  programs.nushellProfile.configDir = ../config/fedex/nushell;
  programs.gitProfile.hostname = "MAC-K03793KGLV";

  # home.activation.fedexPostSwitch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   if command -v kubectl >/dev/null 2>&1; then
  #     kubectl config unset current-context >/dev/null 2>&1 || true
  #   fi

  #   if command -v gcloud >/dev/null 2>&1; then
  #     gcloud auth login
  #   fi

  #   if command -v az >/dev/null 2>&1; then
  #     az login
  #   fi
  # '';

  home.activation.fedexProfileName = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/hm-profile"
    printf '%s\n' 'fedex' > "$HOME/.config/hm-profile/name"
  '';

  home.file =
    lib.mkIf (builtins.pathExists "${config.programs.nushellProfile.configDir}/.gcloud_encryption.nu")
      {
        ".custom_nu/.gcloud_encryption.nu".source =
          "${config.programs.nushellProfile.configDir}/.gcloud_encryption.nu";
      };
}
