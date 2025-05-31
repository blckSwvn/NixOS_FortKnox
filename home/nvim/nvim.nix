{ config, pkgs, ... } : {

home.file.".config/nvim" = {
  source = ./config;
  recursive = true;
  };

home.packages = with pkgs; [
  neovim
  ];
}
