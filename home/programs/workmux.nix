{
  config,
  pkgs,
  workmux,
  ...
}:

{
  home.packages = [
    workmux.packages.${pkgs.system}.default
  ];

  home.file.".config/workmux/config.yaml".source = "${config.my.configRoot}/workmux/config.yaml";

}
