{
  description = "Gee's system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin"; #"x86_64-linux";  # or "aarch64-darwin" for M1 Mac, "x86_64-darwin" for Intel Mac
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations.gee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
        ];
      };

      defaultPackage.${system} = self.homeConfigurations.gee.activationPackage;
    };
}
