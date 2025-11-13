{ config, pkgs, ... } : {

  home.file.".config/river/init" = {
    source = ./config/init;
    executable = true;
  };

  home.file.".config/river/wallpaper.sh" = {
    source = ./config/wallpaper.sh;
    executable = true;
  };

  home.packages = with pkgs; [
    river
      bibata-cursors
      wlr-randr
      rivercarro
      xdg-desktop-portal
      xdg-desktop-portal-wlr
  ];
                        }
