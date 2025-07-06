{ config, pkgs, ... } : {

home.file.".config/river" = {
  source = ./config;
  recursive = true;
  };

home.packages = with pkgs; [
  river
  rivercarro
  xdg-desktop-portal
  xdg-desktop-portal-wlr
  ];
}
