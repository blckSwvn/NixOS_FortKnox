{ config, pkgs, ... } : {

	home.file.".config/hypr" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
		hyprland
    bibata-cursors
	];
			}
