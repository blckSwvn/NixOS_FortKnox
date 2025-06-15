{ config, pkgs, ... } : {

home.file.".config/starship" = {
  source = ./config;
  recursive = true;
  };

home.packages = with pkgs; [
  ];
}
