{ config, pkgs, ... }: {
  home.file.".librewolf" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
  librewolf
  ];
                       }
