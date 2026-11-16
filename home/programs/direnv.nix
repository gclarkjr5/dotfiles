{ ... }:

# Loads per-directory environments (e.g. a repo's flake dev shell via a
# `.envrc` containing `use flake`) when you cd in, and unloads them when you
# leave. nix-direnv caches the shell and protects it from garbage collection.
#
# The nushell hook lives in config.nu, because nushell's config files are
# managed directly (see ./nushell.nix) rather than via programs.nushell.
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
