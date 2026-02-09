{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.yazi
  ];

  home.file.".config/yazi/init.lua".source = ../config/yazi/init.lua;
  home.file.".config/yazi/keymap.toml".source = ../config/yazi/keymap.toml;
  home.file.".config/yazi/theme.toml".source = ../config/yazi/theme.toml;
  home.file.".config/yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  # home.file.".config/yazi/package.template.toml".source = ../config/yazi/package.template.toml;

  # packages
  home.file.".config/yazi/plugins/arrow.yazi/main.lua".source =
    ../config/yazi/plugins/arrow.yazi/main.lua;
  home.file.".config/yazi/plugins/duckdb.yazi/main.lua".source =
    ../config/yazi/plugins/duckdb.yazi/main.lua;
  home.file.".config/yazi/plugins/fg.yazi/main.lua".source = ../config/yazi/plugins/fg.yazi/main.lua;
  home.file.".config/yazi/plugins/folder-rules.yazi/main.lua".source =
    ../config/yazi/plugins/folder-rules.yazi/main.lua;
  home.file.".config/yazi/plugins/full-border.yazi/main.lua".source =
    ../config/yazi/plugins/full-border.yazi/main.lua;
  home.file.".config/yazi/plugins/git.yazi/main.lua".source =
    ../config/yazi/plugins/git.yazi/main.lua;
  home.file.".config/yazi/plugins/gitui.yazi/main.lua".source =
    ../config/yazi/plugins/gitui.yazi/main.lua;
  home.file.".config/yazi/plugins/mdcat.yazi/main.lua".source =
    ../config/yazi/plugins/mdcat.yazi/main.lua;
  home.file.".config/yazi/plugins/mime-ext.yazi/main.lua".source =
    ../config/yazi/plugins/mime-ext.yazi/main.lua;
  home.file.".config/yazi/plugins/parent-arrow.yazi/main.lua".source =
    ../config/yazi/plugins/parent-arrow.yazi/main.lua;
  home.file.".config/yazi/plugins/smart-enter.yazi/main.lua".source =
    ../config/yazi/plugins/smart-enter.yazi/main.lua;
  home.file.".config/yazi/plugins/smart-filter.yazi/main.lua".source =
    ../config/yazi/plugins/smart-filter.yazi/main.lua;
  home.file.".config/yazi/plugins/starship.yazi/main.lua".source =
    ../config/yazi/plugins/starship.yazi/main.lua;
  home.file.".config/yazi/plugins/toggle-pane.yazi/main.lua".source =
    ../config/yazi/plugins/toggle-pane.yazi/main.lua;
  home.file.".config/yazi/plugins/vcs-files.yazi/main.lua".source =
    ../config/yazi/plugins/vcs-files.yazi/main.lua;

  # 🔧 Add a hook to install plugins after config is linked
  # home.activation.installYaziPlugins = config.lib.dag.entryAfter [ "writeBoundary" ] ''
  #   cp "$HOME/.config/yazi/package.template.toml" "$HOME/.config/yazi/package.toml"
  #   echo "Run ya pkg install to Install your Yazi plugins"
  #   echo "Afterwards, uncomment your init.lua to require the plugins"
  # '';
}
