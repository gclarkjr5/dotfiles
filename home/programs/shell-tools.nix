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
    uv
    terraform
    tflint
    go-task
    vscode-extensions.llvm-org.lldb-vscode
    azure-cli
    kubectl
    docker
    docker-compose
    ruff
    ty
    pre-commit
    nixfmt-rfc-style
    buf
    duckdb
    mkcert
    fnm
    mdbook
    cargo-tauri
    curl
    ngrok
    git-cliff
    flyctl
  ];

}
