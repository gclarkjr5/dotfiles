def nix-switch [profile: string] {
      nu --commands $"cd ~/dotfiles; nix run home-manager -- switch --impure --flake .#($profile)"
}
