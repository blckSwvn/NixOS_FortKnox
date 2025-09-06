{ config, pkgs, ... } : {

  home.file.".config/wofi" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    wofi
  ];
                        }
