{
	description = "NixOS FortKnox";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};
	outputs = { self, nixpkgs, unstable, neovim-nightly-overlay, home-manager, ... }:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs { 
				inherit system; 
				config.allowUnfree = true;
			};
			unstablePkgs = import unstable { 
				inherit system; 
				config.allowUnfree = true;
			};
		in {
			nixosConfigurations = {
				Cyclops = nixpkgs.lib.nixosSystem {
					inherit system;
					specialArgs = { 
						inherit unstablePkgs;
					};
					modules = [
						./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.blckSwan = import ./home.nix;
							programs.neovim.enable = true;
							programs.neovim.package = neovim-nightly-overlay.packages.${pkgs.system}.default;
						}
						({ config, pkgs, ... }: {
							nixpkgs.config.allowUnfree = true;
						})
					];
				};
			};
		};
}

