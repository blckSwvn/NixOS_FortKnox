{ config, pkgs, ... } : {

  home.file.".config/" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
  ];
                        }
