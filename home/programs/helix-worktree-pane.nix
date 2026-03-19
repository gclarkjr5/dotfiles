{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "helix-worktree-pane";
      runtimeInputs = [
        pkgs.git
        pkgs.wezterm
        pkgs.fzf
        pkgs.bash
      ];
      text = builtins.readFile ../scripts/helix-worktree-pane.sh;
    })
  ];
}
