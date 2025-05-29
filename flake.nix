{
  description = "Nixos FortKnox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable, ... }: {
    nixosConfigurations.null = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass nixpkgs config cleanly here
      specialArgs = {
        unstablePkgs = import unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      modules = [
        ./configuration.nix
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
        })
      ];
    };
  };
}
