{ config, pkgs, ... } : {

  # home.file.".config/waybar" = {
  #   source = ./config;
  #   recursive = true;
  # };

  home.packages = with pkgs; [
    waybar
  ];
                        }
