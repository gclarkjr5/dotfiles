{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/github/copilot-cli/releases/download/v1.0.14/copilot-darwin-arm64.tar.gz";
    sha256 = "sha256:bf7154d542c1eba2e2c054d195b18d508a365f51f8a938b8c096ad5af7bad244";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "copilot";
    version = "v1.0.14";

    src = tarball;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src

      cp copilot $out/bin/
      chmod +x $out/bin/copilot
    '';
  };

in
{
  home.packages = [ github-release ];
}
