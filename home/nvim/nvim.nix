{ config, pkgs, ... } : {

  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };

#nvim installed directly through flake
  home.packages = with pkgs; [
  ];
                        }
