{ config, pkgs, ... } : {

  home.file.".config/cmus" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    cmus
  ];
                        }
