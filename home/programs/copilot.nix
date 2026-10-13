{ config, pkgs, ... }:

let
  tarball = pkgs.fetchurl {
    url = "https://github.com/github/copilot-cli/releases/download/v1.0.96/copilot-darwin-arm64.tar.gz";
    sha256 = "sha256:0964fd63cc55e2964deb3d0cb005cd5fa04f803120eb3104635bc4e1664968a4";
  };

  github-release = pkgs.stdenv.mkDerivation {
    pname = "copilot";
    version = "v1.0.96";

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
