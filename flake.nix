{
  description = "Nixos FortKnox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, unstable, home-manager, ... }: {
    nixosConfigurations.Cyclops = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        unstablePkgs = import unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      modules = [
        ./configuration.nix

        # Home Manager system integration
        home-manager.nixosModules.home-manager

        # Allow unfree software
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;

          # User home manager config
          home-manager.users.blckSwan = import ./home.nix;
        })
      ];
    };

    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        unstablePkgs = import unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      modules = [
        ./isoConfiguration.nix
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      ];
    };
  };
}
