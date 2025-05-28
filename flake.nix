{
  description = "Nixos FortKnox";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs, sops-nix }: {
nixosConfigurations.null = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	./configuration.nix
	];
    };
  };
}
