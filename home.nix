{ config, pkgs, unstablePkgs, ... } : {

  imports = [
      ./home/nvim/nvim.nix
      ./home/kitty/kitty.nix
      ./home/wofi/wofi.nix
      ./home/waybar/waybar.nix
      ./home/starship/starship.nix
      ./home/river/river.nix
      ./home/hyprland/hyprland.nix
  ];

  home.username = "blckSwan";
  home.homeDirectory = "/home/blckSwan";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
                                      }
