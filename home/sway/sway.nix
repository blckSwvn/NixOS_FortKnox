{ config, pkgs, ... } : {

home.file.".config/sway" = {
  source = ./config;
  recursive = true;
  };

home.packages = with pkgs; [
  sway
  ];
}
