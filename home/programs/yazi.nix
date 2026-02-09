{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.yazi
  ];

  home.file.".config/yazi/init.lua".source = ../config/yazi/init.lua;
  home.file.".config/yazi/keymap.toml".source = ../config/yazi/keymap.toml;
  home.file.".config/yazi/theme.toml".source = ../config/yazi/theme.toml;
  home.file.".config/yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  home.file.".config/yazi/package.template.toml".source = ../config/yazi/package.template.toml;

  # 🔧 Add a hook to install plugins after config is linked
  home.activation.installYaziPlugins = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    cp "$HOME/.config/yazi/package.template.toml" "$HOME/.config/yazi/package.toml"
    echo "Run ya pkg install to Install your Yazi plugins"
    echo "Afterwards, uncomment your init.lua to require the plugins"
  '';
}
