{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server
    terraform-ls
    yaml-language-server
    jq-lsp
    vscode-json-languageserver
    sqls
    pyright
  ];
}
