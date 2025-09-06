{ config, pkgs, ... } : {

  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };

#installed directly through flake
                        }
