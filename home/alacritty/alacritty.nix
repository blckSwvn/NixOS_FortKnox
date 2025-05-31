{ config, pkgs, ... } : {

home.file.".config/alacritty" = {
  source = ./config;
  recursive = true;
  };

home.packages = with pkgs; [
  alacritty
  ];
}
