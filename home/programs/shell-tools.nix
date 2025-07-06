{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    ripgrep
    zoxide
    fzf
    bat
    jless
    inlyne
    file
    poppler
    jq
    zip
    _7zz
    bash
    gh
    k9s
    lua-language-server
    uv
    # telnet
    # ping
    terraform
    terraform-ls
    yaml-language-server
    go-task
    vscode-extensions.llvm-org.lldb-vscode
    azure-cli
    kubectl
    docker
    docker-compose
    ruff
    pre-commit
  ];

}
