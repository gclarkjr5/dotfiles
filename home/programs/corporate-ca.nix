{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.corporateCa;
in
{
  options.programs.corporateCa = {
    enable = lib.mkEnableOption "corporate MITM proxy CA bundle generation";

    certificateNames = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Common names of the corporate root/intermediate CAs to export from the
        macOS System keychain and append to the Mozilla trust store.
      '';
    };

    bundlePath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.local/share/certs/corporate-ca-bundle.pem";
      description = "Where the combined CA bundle is written.";
    };
  };

  config = lib.mkIf cfg.enable {
    # The corporate network terminates TLS with a MITM proxy. Nix ships its own
    # trust store, so it has to be given a bundle that also contains the
    # corporate CAs, otherwise every fetch fails with "unable to get local
    # issuer certificate".
    home.activation.corporateCaBundle = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      bundle="${cfg.bundlePath}"
      $DRY_RUN_CMD mkdir -p "$(dirname "$bundle")"
      tmp="$(mktemp)"
      cat /etc/ssl/cert.pem > "$tmp"
      ${lib.concatMapStringsSep "\n" (name: ''
        /usr/bin/security find-certificate -a -c ${lib.escapeShellArg name} -p \
          /Library/Keychains/System.keychain >> "$tmp" || true
      '') cfg.certificateNames}
      $DRY_RUN_CMD install -m 0644 "$tmp" "$bundle"
      rm -f "$tmp"
    '';
  };
}
