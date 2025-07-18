{ config, pkgs, ... } : {

#home.file.".config/kitty" = {
#  source = ./config;
#  recursive = true;
#  };

home.packages = with pkgs; [
  kitty
  ];
}
